import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/cryptocurrency/presentation/view/detail.dart';
import '../../pages/home.dart';

class AppRoutes {
  static const home = "home";
  static const detail = "detail";

  static transition({required Widget child}) {
    return CustomTransitionPage(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }

  void clearAndNavigate(String name) {
    while (goRouter.canPop() == true) {
      goRouter.pop();
    }
    goRouter.pushReplacementNamed(name);
  }

  void forceLogout() {
    //TODO do force logout
  }

  static final GoRouter goRouter = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        name: home,
        path: '/home',
        pageBuilder: _homePageBuilder,
      ),
      GoRoute(
        name: detail,
        path: '/detail',
        pageBuilder: _detailPageBuilder,
      ),
    ],
  );

  static Page _homePageBuilder(BuildContext context, GoRouterState state) {
    return transition(
      child: const HomePage(),
    );
  }

  static Page _detailPageBuilder(BuildContext context, GoRouterState state) {
    final String symbol = state.extra as String;
    return transition(
      child: DetailPage(
        symbol: symbol,
      ),
    );
  }
}
