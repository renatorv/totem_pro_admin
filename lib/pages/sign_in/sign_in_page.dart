// tested with just a hot reload.
import 'package:flutter/material.dart';
import 'package:totem_pro_admin/core/extensions.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            flex: 2,
            child: Column(
              children: [],
            ),
          ),
          if (!context.isMobile)
            Expanded(
              flex: 3,
              child: Container(color: Colors.blue),
            ),
        ],
      ),
    );
  }
}
