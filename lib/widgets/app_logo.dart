import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w300,
        ),
        children: const [
          TextSpan(
            text: 'Totem',
          ),
          TextSpan(
            text: 'PRO',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.blue
            ),
          ),
        ],
      ),
    );
  }
}
