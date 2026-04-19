import 'package:flutter/material.dart';

class SplashBrand extends StatelessWidget {
  const SplashBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/medipass_logo.png',
          fit: BoxFit.contain,
          height: 48,
        ),
      ],
    );
  }
}