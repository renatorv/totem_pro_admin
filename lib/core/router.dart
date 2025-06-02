import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totem_pro_admin/core/di.dart';
import 'package:totem_pro_admin/pages/sign_in/sign_in_page.dart';
import 'package:totem_pro_admin/pages/splash/splash_page.dart';
import 'package:totem_pro_admin/repositories/auth_repository.dart';

final router = GoRouter(
  initialLocation: '/splash',
  observers: [BotToastNavigatorObserver()],
  debugLogDiagnostics: true,
  redirect: (context, state) {
    if (state.fullPath != '/splash') {
      final bool isInicialized = getIt.isRegistered<bool>(instanceName: 'isInitialized');
      if (!isInicialized) {
        return '/splash?redirectTo=${state.matchedLocation}';
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, state) => SplashPage(
        redirectTo: state.uri.queryParameters['redirectTo'],
      ),
      redirect: (context, state) {
        final bool isInicialized = getIt.isRegistered<bool>(instanceName: 'isInitialized');
        if (isInicialized) {
          return '/sign-in';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/sign-in',
      builder: (_, state) => SignInPage(
        redirectTo: state.uri.queryParameters['redirectTo'],
      ),
    ),
    GoRoute(
      path: '/home',
      redirect: (_, state) {
        final AuthRepository authRepository = getIt();
        if (authRepository.authTokens != null) {
          return '/home';
        }
        return null;
      },
      builder: (_, state) => Container(),
    ),
        GoRoute(
      path: '/products',
      redirect: (_, state) {
        final AuthRepository authRepository = getIt();
        if (authRepository.authTokens == null) {
          return '/sign-in?redirectTo=/products';
        }
        return null;
      },
      builder: (_, state) => Container(),
    ),
  ],
);
