import 'dart:async';

import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:cookain/auth/presentation/pages/sign_in_page.dart';
import 'package:cookain/home_navigation/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyGoRouter {

  final AuthCubit authCubit;

  MyGoRouter({required this.authCubit});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static void pop() {
    GoRouter.of(context).pop();
  }

  static void maybePop() {
    if (GoRouter.of(context).canPop()) pop();
  }

  late final router = GoRouter(
    initialLocation: homeRoute,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    routes: <GoRoute>[
      GoRoute(
        path: homeRoute,
        name: homeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        }
      ),
      GoRoute(
        path: signInRoute,
        name: signInName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignInPage());
        }
      ),
    ],
    redirect: (context, state) {
      final bool isLoggedIn = authCubit.state is AuthSignedIn;
      if (isLoggedIn) {

        if (_needSignedInRoutes.any(
          (element) => state.matchedLocation.contains(element)
        )) return null;

        return homeRoute;
      } else {
        return signInRoute;
      }
    }
  );

  static const signInRoute = "/signIn";
  static const signInName = "signIn";

  static const homeRoute = "/home";
  static const homeName = "home";
  
  static const _needSignedInRoutes = [
    homeRoute,
  ];

}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}