import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:totem_pro_admin/pages/sign_in/sign_in_page.dart';
import 'package:totem_pro_admin/pages/splash/splash_page.dart';

final router = GoRouter(
  initialLocation: '/splash',
  observers: [BotToastNavigatorObserver()],
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: '/sign-in',
      builder: (_, state) {
        return const SignInPage();
      },
    ),
  ],
);
