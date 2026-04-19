import 'package:flutter/material.dart';

import 'social_auth_button.dart';

class AuthSocialRow extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final VoidCallback onFacebookTap;

  const AuthSocialRow({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
    required this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialAuthButton(
          onTap: onGoogleTap,
          child: const Text(
            'G',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(width: 20),
        SocialAuthButton(
          onTap: onAppleTap,
          child: const Icon(
            Icons.apple,
            size: 30,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(width: 20),
        SocialAuthButton(
          onTap: onFacebookTap,
          child: const Icon(
            Icons.facebook,
            size: 30,
            color: Color(0xFF1877F2),
          ),
        ),
      ],
    );
  }
}