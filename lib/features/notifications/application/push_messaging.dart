import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/api/api_client.dart';

/// A push as the app sees it: what the system shows, and its data. The
/// data holds the inbox item's own (kind, matchId…) plus notificationId and
/// actionUrl, all strings.
class PushMessage {
  const PushMessage({this.title, this.body, this.data = const {}});

  final String? title;
  final String? body;
  final Map<String, String> data;

  String? get notificationId => data['notificationId'];
}

/// The device's push channel: Firebase Cloud Messaging where it's set up,
/// nothing elsewhere (iOS until its Firebase config is added, and tests).
abstract class PushMessaging {
  /// `android` or `ios`, as the API names them.
  String get platform;

  /// Asks the player to allow notifications, where the system needs it.
  Future<bool> requestPermission();

  /// The registration token to give the API, or null without one.
  Future<String?> token();

  /// A new token, when Firebase rotates it.
  Stream<String> get tokenRefreshes;

  /// Pushes that arrive while the app is open, which the system doesn't
  /// show.
  Stream<PushMessage> get foreground;

  /// Pushes the player tapped while the app was in the background.
  Stream<PushMessage> get opened;

  /// The push that launched the app from closed, if one did.
  Future<PushMessage?> initial();
}

class FirebasePushMessaging implements PushMessaging {
  FirebasePushMessaging({required this.platform});

  @override
  final String platform;

  late final Future<FirebaseApp> _ready = Firebase.initializeApp();

  Future<FirebaseMessaging> get _messaging async {
    await _ready;
    return FirebaseMessaging.instance;
  }

  @override
  Future<bool> requestPermission() async {
    final settings = await (await _messaging).requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  // The API sends with FCM HTTP v1 to registration tokens, which these
  // return. register() and onRegistered, their replacements, give an
  // installation id for FCM's direct send, which the API doesn't use.
  @override
  Future<String?> token() async =>
      // ignore: deprecated_member_use
      (await _messaging).getToken();

  @override
  Stream<String> get tokenRefreshes => Stream.fromFuture(_messaging)
      // ignore: deprecated_member_use
      .asyncExpand((m) => m.onTokenRefresh);

  @override
  Stream<PushMessage> get foreground =>
      Stream.fromFuture(_ready)
          .asyncExpand((_) => FirebaseMessaging.onMessage.map(_message));

  @override
  Stream<PushMessage> get opened => Stream.fromFuture(_ready)
      .asyncExpand((_) => FirebaseMessaging.onMessageOpenedApp.map(_message));

  @override
  Future<PushMessage?> initial() async {
    final message = await (await _messaging).getInitialMessage();
    return message == null ? null : _message(message);
  }

  static PushMessage _message(RemoteMessage m) => PushMessage(
    title: m.notification?.title,
    body: m.notification?.body,
    data: {for (final e in m.data.entries) e.key: '${e.value}'},
  );
}

/// No pushes: where Firebase isn't set up.
class NoPushMessaging implements PushMessaging {
  const NoPushMessaging({this.platform = 'ios'});

  @override
  final String platform;

  @override
  Future<bool> requestPermission() async => false;

  @override
  Future<String?> token() async => null;

  @override
  Stream<String> get tokenRefreshes => const Stream.empty();

  @override
  Stream<PushMessage> get foreground => const Stream.empty();

  @override
  Stream<PushMessage> get opened => const Stream.empty();

  @override
  Future<PushMessage?> initial() async => null;
}

/// Where the device keeps its push identity: a stable id for this install,
/// and the installation the API made for it.
abstract class PushStore {
  /// Made once per install and kept.
  Future<String> deviceId();
  Future<String?> installationId();
  Future<void> writeInstallationId(String id);
  Future<void> clearInstallationId();
}

class SecurePushStore implements PushStore {
  SecurePushStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _device = 'ozone_device_id';
  static const _installation = 'ozone_push_installation';

  @override
  Future<String> deviceId() async {
    final known = await _storage.read(key: _device);
    if (known != null) return known;
    final id = newUuid();
    await _storage.write(key: _device, value: id);
    return id;
  }

  @override
  Future<String?> installationId() => _storage.read(key: _installation);

  @override
  Future<void> writeInstallationId(String id) =>
      _storage.write(key: _installation, value: id);

  @override
  Future<void> clearInstallationId() => _storage.delete(key: _installation);
}
