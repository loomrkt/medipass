import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBack;

  const AuthHeader({
    super.key,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.6, 1.0],
          colors: [
            Color(0xFF2B88F0), // Radiant blue from the images
            Color(0xFFB1D8FB), // Lighter blue transition
            Colors.white,      // Fades completely into white
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (showBackButton)
                Positioned(
                  left: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: onBack ?? () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/medipass_logo.png',
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
