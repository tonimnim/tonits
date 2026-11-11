import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

/// A non-2xx answer from the API. Every error body is
/// `{"error": "<code>", "message": "<text>"}`.
class ApiException implements Exception {
  ApiException({
    required this.status,
    required this.code,
    required this.message,
    this.requestId,
    this.retryAfter,
    this.details = const {},
  });

  final int status;
  final String code;
  final String message;
  final String? requestId;

  /// From the `Retry-After` header on a `429`.
  final Duration? retryAfter;

  /// The whole error body, for typed errors that carry more than a code
  /// (such as `payment_in_progress` with its `paymentId`).
  final Map<String, dynamic> details;

  @override
  String toString() => 'ApiException($status $code: $message)';
}

/// The request never got an HTTP answer: offline, DNS, timeout.
class NetworkException implements Exception {
  NetworkException(this.cause);
  final Object cause;

  @override
  String toString() => 'NetworkException($cause)';
}

/// Called on a `401` to rotate the session. Returns the new access token, or
/// null when the session is over and the player must sign in again.
typedef SessionRefresher = Future<String?> Function();

/// Thin JSON transport for the Orbits API. It attaches `X-Request-ID` and the
/// bearer token, and keeps the session alive the way large apps do:
///
/// * A token about to expire is renewed before the request goes out, so a
///   player coming back to the app doesn't pay for a `401` first.
/// * A `401` makes one refresh, shared by every request that got one at the
///   same time, then retries the request once. A request that was already out
///   when another one renewed the session just retries with the new token.
/// * A public read sent signed in ([send]'s `optionalAuth`) never fails for
///   the session's sake: once the session is over it reads as signed out.
class ApiClient {
  ApiClient({
    required String baseUrl,
    http.Client? httpClient,
    this.timeout = const Duration(seconds: 20),
    DateTime Function()? clock,
  }) : baseUri = Uri.parse(baseUrl),
       _http = httpClient ?? http.Client(),
       _clock = clock ?? DateTime.now;

  final Uri baseUri;
  final http.Client _http;
  final Duration timeout;
  final DateTime Function() _clock;

  /// How long before it expires an access token is renewed.
  static const refreshAhead = Duration(minutes: 1);

  String? _accessToken;
  DateTime? _accessTokenExpiresAt;

  /// The bearer token. Set this way its lifetime is unknown, so it is only
  /// renewed after a `401`; [useAccessToken] also renews it ahead of time.
  String? get accessToken => _accessToken;
  set accessToken(String? token) {
    _accessToken = token;
    _accessTokenExpiresAt = null;
  }

  /// Takes a token the API issued along with its lifetime (`expiresInSeconds`).
  /// The lifetime is counted on this phone's clock, so a wrong clock can't
  /// make it look expired or fresh.
  void useAccessToken(String token, {required Duration expiresIn}) {
    _accessToken = token;
    _accessTokenExpiresAt = _clock().add(expiresIn);
  }

  SessionRefresher? onUnauthorized;
  Future<String?>? _refreshing;

  /// [auth] requires the player's session; [optionalAuth] sends it when there
  /// is one, for a public read that adds the player's own fields (such as a
  /// competition's `reminderSet`).
  Future<Map<String, dynamic>?> get(
    String path, {
    bool auth = false,
    bool optionalAuth = false,
  }) => send('GET', path, auth: auth, optionalAuth: optionalAuth);

  Future<Map<String, dynamic>?> post(
    String path, {
    Object? body,
    bool auth = false,
    Map<String, String>? headers,
  }) => send('POST', path, body: body, auth: auth, headers: headers);

  Future<Map<String, dynamic>?> send(
    String method,
    String path, {
    Object? body,
    bool auth = false,
    bool optionalAuth = false,
    Map<String, String>? headers,
  }) async {
    final signed = auth || optionalAuth;
    if (signed) await _renewIfExpiring();
    final sent = signed ? _accessToken : null;
    var response = await _send(method, path, body, sent, headers);
    if (response.statusCode == 401 && (auth || sent != null)) {
      // Another request may have renewed the session while this one was
      // out; only a token nobody has replaced yet needs a refresh.
      final current = _accessToken;
      final token = current != null && current != sent
          ? current
          : await _renew();
      if (token != null) {
        response = await _send(method, path, body, token, headers);
      }
      if (response.statusCode == 401 && optionalAuth) {
        // The session is over, but the read is public: answer it as for a
        // signed-out player rather than failing the screen.
        response = await _send(method, path, body, null, headers);
      }
    }
    return _decode(response);
  }

  /// Uploads raw bytes to a signed storage URL (not the API), with exactly
  /// the headers the API asked for. Returns the status code; a 412 on a
  /// retry can mean an earlier attempt already stored the file.
  Future<int> putBytes(
    Uri url,
    Uint8List bytes, {
    required Map<String, String> headers,
  }) async {
    final request = http.Request('PUT', url)..bodyBytes = bytes;
    // The body sets Content-Length itself; a second copy would conflict.
    headers.forEach((name, value) {
      if (name.toLowerCase() != 'content-length') request.headers[name] = value;
    });
    try {
      final streamed = await _http
          .send(request)
          .timeout(const Duration(seconds: 90));
      final response = await http.Response.fromStream(streamed);
      return response.statusCode;
    } on Exception catch (e) {
      // Only the transfer is in here: a timeout, a dropped connection, or
      // a TLS failure (a captive portal, a wrong clock) all mean offline.
      throw NetworkException(e);
    }
  }

  /// Resolves an API-relative reference (such as a legal document's
  /// `contentUrl`) against the API origin.
  Uri resolve(String reference) => baseUri.resolve(reference);

  /// The new access token, or null when the session is over. Every caller at
  /// the same time shares one refresh: each refresh spends the stored refresh
  /// token, so a second one at once would be refused.
  Future<String?> _renew() {
    final refresher = onUnauthorized;
    if (refresher == null) return Future.value();
    return _refreshing ??= refresher().whenComplete(() {
      _refreshing = null;
    });
  }

  /// Renews a token that is about to expire. A failure here (offline, the
  /// API busy) is not the request's failure: it goes out with the token it
  /// has, and a `401` tries again.
  Future<void> _renewIfExpiring() async {
    final expiresAt = _accessTokenExpiresAt;
    if (_accessToken == null || expiresAt == null) return;
    if (_clock().isBefore(expiresAt.subtract(refreshAhead))) return;
    try {
      await _renew();
    } on Exception {
      // As above: send what we have.
    }
  }

  Future<http.Response> _send(
    String method,
    String path,
    Object? body,
    String? token,
    Map<String, String>? extraHeaders,
  ) async {
    final request = http.Request(method, baseUri.resolve(path));
    request.headers['Accept'] = 'application/json';
    request.headers['X-Request-ID'] = newUuid();
    if (token != null) request.headers['Authorization'] = 'Bearer $token';
    if (extraHeaders != null) request.headers.addAll(extraHeaders);
    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }
    try {
      final streamed = await _http.send(request).timeout(timeout);
      return await http.Response.fromStream(streamed).timeout(timeout);
    } on Exception catch (e) {
      // As in putBytes: anything from the transfer itself is offline.
      throw NetworkException(e);
    }
  }

  Map<String, dynamic>? _decode(http.Response response) {
    final ok = response.statusCode >= 200 && response.statusCode < 300;
    Object? json;
    if (response.body.isNotEmpty) {
      try {
        json = jsonDecode(response.body);
      } on FormatException {
        json = null;
      }
    }
    if (ok) return json is Map<String, dynamic> ? json : null;

    final error = json is Map<String, dynamic>
        ? json
        : const <String, dynamic>{};
    final retryAfter = int.tryParse(response.headers['retry-after'] ?? '');
    throw ApiException(
      status: response.statusCode,
      code: error['error'] as String? ?? 'http_${response.statusCode}',
      message:
          error['message'] as String? ??
          'Request failed with status ${response.statusCode}',
      requestId: response.headers['x-request-id'],
      retryAfter: retryAfter == null ? null : Duration(seconds: retryAfter),
      details: error,
    );
  }
}

final _random = Random.secure();

/// A random (version 4) UUID, for `X-Request-ID` and `Idempotency-Key`.
String newUuid() {
  final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
      '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
