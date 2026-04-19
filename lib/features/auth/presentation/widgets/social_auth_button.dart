import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const SocialAuthButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF3F4F6),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(child: child),
        ),
      ),
    );
  }
}