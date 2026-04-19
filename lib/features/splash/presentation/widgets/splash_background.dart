import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;

  const SplashBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.splashBlueTop,
                  AppColors.splashBlueBottom,
                ],
              ),
            ),
          ),
          Opacity(
            opacity: 0.05,
            child: Image.asset(
              'assets/images/pattern_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}