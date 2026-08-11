import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app.routes.dart';

abstract final class RouterHelper {
  static void goToLogin(BuildContext context) =>
      context.goNamed(AppRoutes.loginName);

  static void goToHome(BuildContext context) =>
      context.goNamed(AppRoutes.homeName);
}
