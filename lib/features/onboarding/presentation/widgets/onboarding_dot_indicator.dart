import 'package:flutter/material.dart';

class OnboardingDotIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const OnboardingDotIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final bool isActive = index == currentIndex;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? const Color(0xFF56A8E9) : Colors.white,
              border: Border.all(
                color: const Color(0xFF1E73E8),
                width: 1.2,
              ),
            ),
          );
        },
      ),
    );
  }
}