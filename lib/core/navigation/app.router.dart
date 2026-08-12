import 'package:go_router/go_router.dart';
import 'package:mangatek_flutter/features/auth/presentation/pages/login.page.dart';
import 'package:mangatek_flutter/features/home/presentation/pages/home.page.dart';

import 'app.routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      name: AppRoutes.loginName,
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: AppRoutes.homeName,
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
