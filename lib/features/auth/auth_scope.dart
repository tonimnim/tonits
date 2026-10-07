import 'package:flutter/widgets.dart';

import 'auth_controller.dart';

/// Makes the [AuthController] available to the widget tree and rebuilds
/// dependents when the session changes.
class AuthScope extends InheritedNotifier<AuthController> {
  const AuthScope({
    super.key,
    required AuthController controller,
    required super.child,
  }) : super(notifier: controller);

  static AuthController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AuthScope>()!.notifier!;

  /// For event handlers, which must not subscribe to rebuilds.
  static AuthController read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<AuthScope>()!.notifier!;
}
