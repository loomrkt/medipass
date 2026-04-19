import 'package:flutter/material.dart';

class BiometricAuthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const BiometricAuthButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: const BorderSide(color: Color(0xFFD9D9D9)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      icon: Icon(icon, color: const Color(0xFF2F80ED)),
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1F2A44),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}