import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totem_pro_admin/core/di.dart';
import 'package:totem_pro_admin/repositories/auth_repository.dart';
import 'package:totem_pro_admin/widgets/app_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.redirectTo});

  final String? redirectTo;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLogo(size: 50),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    initialize();
  }

  Future<void> initialize() async {
    final AuthRepository authRepository = getIt();
    await authRepository.initialize();
    if (!mounted) return;

    getIt.registerSingleton(true, instanceName: 'isInitialized');

    context.go(widget.redirectTo ?? '/sign-in');
  }
}
