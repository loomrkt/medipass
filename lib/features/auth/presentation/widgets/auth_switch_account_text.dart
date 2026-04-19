import 'package:flutter/material.dart';

class AuthSwitchAccountText extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLogin;

  const AuthSwitchAccountText({
    super.key,
    required this.onTap,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF7C8593),
          ),
          children: [
            TextSpan(
              text: isLogin
                  ? "Vous n'avez pas de compte ? "
                  : "Vous avez déjà un compte ? ",
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  isLogin ? "S’inscrire" : "Se connecter",
                  style: const TextStyle(
                    color: Color(0xFF2E3142),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}