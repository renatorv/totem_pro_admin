import 'package:go_router/go_router.dart';
import 'package:totem_pro_admin/pages/sign_in/sign_in_page.dart';

final router = GoRouter(
  initialLocation: '/sign-in',
  routes: [
    GoRoute(
      path: '/sign-in',
      builder: (_, state) => const SignInPage(),
    ),
  ],
);
