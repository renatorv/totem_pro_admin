import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:totem_pro_admin/core/di.dart';
import 'package:totem_pro_admin/core/router.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Totem PRO - Admin',
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routerConfig: router,
    );
  }
}