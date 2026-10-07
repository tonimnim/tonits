import 'dart:async';
import 'dart:convert';
import 'dart:math';

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
  });

  final int status;
  final String code;
  final String message;
  final String? requestId;

  /// From the `Retry-After` header on a `429`.
  final Duration? retryAfter;

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

/// Thin JSON transport for the Tonits API. It attaches `X-Request-ID` and the
/// bearer token, and on a `401` makes one serialized refresh attempt before
/// retrying the request once.
class ApiClient {
  ApiClient({
    required String baseUrl,
    http.Client? httpClient,
    this.timeout = const Duration(seconds: 20),
  }) : baseUri = Uri.parse(baseUrl),
       _http = httpClient ?? http.Client();

  final Uri baseUri;
  final http.Client _http;
  final Duration timeout;

  String? accessToken;
  SessionRefresher? onUnauthorized;
  Future<String?>? _refreshing;

  Future<Map<String, dynamic>?> get(String path, {bool auth = false}) =>
      send('GET', path, auth: auth);

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
    Map<String, String>? headers,
  }) async {
    var response = await _send(method, path, body, auth, headers);
    if (response.statusCode == 401 && auth && onUnauthorized != null) {
      final token = await _refreshOnce();
      if (token != null) {
        response = await _send(method, path, body, auth, headers);
      }
    }
    return _decode(response);
  }

  /// Resolves an API-relative reference (such as a legal document's
  /// `contentUrl`) against the API origin.
  Uri resolve(String reference) => baseUri.resolve(reference);

  Future<String?> _refreshOnce() {
    return _refreshing ??= onUnauthorized!().whenComplete(() {
      _refreshing = null;
    });
  }

  Future<http.Response> _send(
    String method,
    String path,
    Object? body,
    bool auth,
    Map<String, String>? extraHeaders,
  ) async {
    final request = http.Request(method, baseUri.resolve(path));
    request.headers['Accept'] = 'application/json';
    request.headers['X-Request-ID'] = newUuid();
    if (auth && accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }
    if (extraHeaders != null) request.headers.addAll(extraHeaders);
    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }
    try {
      final streamed = await _http.send(request).timeout(timeout);
      return await http.Response.fromStream(streamed).timeout(timeout);
    } on TimeoutException catch (e) {
      throw NetworkException(e);
    } on http.ClientException catch (e) {
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

    final error = json is Map<String, dynamic> ? json : const {};
    final retryAfter = int.tryParse(response.headers['retry-after'] ?? '');
    throw ApiException(
      status: response.statusCode,
      code: error['error'] as String? ?? 'http_${response.statusCode}',
      message:
          error['message'] as String? ??
          'Request failed with status ${response.statusCode}',
      requestId: response.headers['x-request-id'],
      retryAfter: retryAfter == null ? null : Duration(seconds: retryAfter),
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
