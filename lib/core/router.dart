import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:totem_pro_admin/core/di.dart';
import 'package:totem_pro_admin/core/guards/auth_guard.dart';
import 'package:totem_pro_admin/core/guards/route_guard.dart';
import 'package:totem_pro_admin/pages/sign_in/sign_in_page.dart';
import 'package:totem_pro_admin/pages/sign_up/sign_up_page.dart';
import 'package:totem_pro_admin/pages/splash/splash_page.dart';

final router = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  observers: [BotToastNavigatorObserver()],
  redirect: (context, state) {
    if (state.fullPath != '/splash') {
      final isInitialized = getIt.isRegistered<bool>(
        instanceName: 'isInitialized',
      );
      if (!isInitialized) {
        return '/splash?redirectTo=${state.matchedLocation}';
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, state) {
        return SplashPage(redirectTo: state.uri.queryParameters['redirectTo']);
      },
      redirect: (context, state) {
        final isInitialized = getIt.isRegistered<bool>(
          instanceName: 'isInitialized',
        );
        if (isInitialized) {
          return '/sign-in';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/sign-in',
      redirect: (_, state) {
        return RouteGuard.apply(
            state,
            [
              AuthGuard(invert: true),
            ]
        );
      },
      builder: (_, state) {
        return SignInPage(
            redirectTo: state.uri.queryParameters['redirectTo']
        );
      },
    ),
    GoRoute(
      path: '/sign-up',
      redirect: (_, state) {
        return RouteGuard.apply(
            state,
            [
              AuthGuard(invert: true),
            ]
        );
      },
      builder: (_, state) {
        return SignUpPage(
            redirectTo: state.uri.queryParameters['redirectTo']
        );
      },
    ),
    GoRoute(
      path: '/home',
      redirect: (_, state) {
        return RouteGuard.apply(
          state,
          [
            AuthGuard(),
          ]
        );
      },
      builder: (_, state) {
        return const Text(
            'HOME'
        );
      },
    ),
    GoRoute(
      path: '/products',
      redirect: (_, state) {
        return RouteGuard.apply(
            state,
            [
              AuthGuard(),
            ]
        );
      },
      builder: (_, state) {
        return const Text(
          'PRODUCTS'
        );
      },
    ),
  ],
);
