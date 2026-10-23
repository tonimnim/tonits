import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import '../../../core/l10n.dart';
import '../../../core/providers.dart';
import '../../../core/routes.dart';
import '../../auth/application/auth_providers.dart';
import '../../chat/application/chat_providers.dart';
import 'notification_target.dart';
import 'notifications_providers.dart';
import 'push_messaging.dart';

/// Pushes on this device: registers it for the signed-in player, opens what
/// a tapped push is about, and refreshes the badge for one that arrives
/// while the app is open. Pushes are a convenience; the inbox always has
/// everything, so a push that fails never stops the player.
class PushService {
  PushService(this._ref);

  final Ref _ref;
  final _subscriptions = <StreamSubscription<Object?>>[];

  /// Where a tapped push leads, held until the player is signed in.
  String? _pending;

  PushMessaging get _messaging => _ref.read(pushMessagingProvider);
  PushStore get _store => _ref.read(pushStoreProvider);

  /// Listens for new tokens, open-app pushes and taps. Once, at launch.
  void start() {
    if (_subscriptions.isNotEmpty) return;
    _subscriptions
      ..add(_messaging.tokenRefreshes.listen((_) => unawaited(register())))
      ..add(_messaging.foreground.listen(_arrived))
      ..add(_messaging.opened.listen((m) => unawaited(_open(m))));
    _ref.onDispose(() {
      for (final s in _subscriptions) {
        unawaited(s.cancel());
      }
    });
    unawaited(
      _messaging.initial().then((m) {
        if (m != null) unawaited(_open(m));
      }, onError: (_) {}),
    );
  }

  /// Registers this device for the signed-in player's pushes. Called after
  /// every sign-in and launch, and when the token changes; the server keeps
  /// one installation per device, so repeating it is harmless.
  Future<void> register() async {
    if (_ref.read(currentPlayerProvider) == null) return;
    try {
      if (!await _messaging.requestPermission()) return;
      final token = await _messaging.token();
      if (token == null) return;
      final id = await _ref
          .read(pushRepositoryProvider)
          .register(
            deviceId: await _store.deviceId(),
            platform: _messaging.platform,
            token: token,
          );
      await _store.writeInstallationId(id);
    } catch (_) {
      // Tried again on the next launch or token change.
    }
  }

  /// Stops pushes to this device. Called before signing out, while the
  /// session can still say so.
  Future<void> unregister() async {
    final id = await _store.installationId();
    if (id == null) return;
    try {
      await _ref.read(pushRepositoryProvider).unregister(id);
    } catch (_) {
      // The server drops it with the session anyway.
    }
    await _store.clearInstallationId();
  }

  /// Opens what a push waiting for sign-in was about.
  void openPending() {
    final location = _pending;
    _pending = null;
    if (location != null) _ref.read(routerProvider).go(location);
  }

  /// A push while the app is open: the system doesn't show it, so the
  /// badge and inbox catch up and a bar offers to open it. A chat already
  /// on screen just reads the new message.
  void _arrived(PushMessage message) {
    _ref
      ..invalidate(unreadCountProvider)
      ..invalidate(inboxProvider);
    final target = NotificationTarget.fromPush(message.data);
    if (target is OpenMatchChat) {
      if (_ref.exists(matchChatProvider(target.matchId))) {
        unawaited(
          _ref.read(matchChatProvider(target.matchId).notifier).refresh(),
        );
      }
      if (_onScreen(Routes.matchChat(target.matchId))) return;
    }
    final title = message.title;
    if (title == null || title.isEmpty) return;
    _ref.read(scaffoldMessengerKeyProvider).currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(title),
          action: SnackBarAction(
            label: _ref.read(l10nProvider).pushOpen,
            onPressed: () => unawaited(_open(message)),
          ),
        ),
      );
  }

  /// A tapped push: marks its inbox item read and opens what it's about,
  /// once the player is signed in.
  Future<void> _open(PushMessage message) async {
    final location = switch (NotificationTarget.fromPush(message.data)) {
      OpenMatchChat(:final matchId) => Routes.matchChat(matchId),
      OpenMatch(:final matchId) => Routes.match(matchId),
      OpenCompetition(:final competitionId) => Routes.competition(
        competitionId,
      ),
      ShowDetails() => Routes.notifications,
    };
    if (_ref.read(currentPlayerProvider) == null) {
      _pending = location;
    } else {
      _ref.read(routerProvider).go(location);
    }
    if (message.notificationId case final id?) {
      try {
        await _ref.read(notificationsRepositoryProvider).markRead(id);
        _ref
          ..invalidate(unreadCountProvider)
          ..invalidate(inboxProvider);
      } catch (_) {
        // It stays unread in the inbox; nothing else depends on it.
      }
    }
  }

  bool _onScreen(String path) =>
      _ref.read(routerProvider).routerDelegate.currentConfiguration.uri.path ==
      path;
}
