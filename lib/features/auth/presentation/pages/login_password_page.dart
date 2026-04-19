import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/login_password_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/auth_social_row.dart';
import '../widgets/auth_switch_account_text.dart';
import '../widgets/auth_header.dart';
import '../widgets/biometric_auth_button.dart';

class LoginPasswordPage extends StatefulWidget {
  final String? email;

  const LoginPasswordPage({
    super.key,
    this.email,
  });

  @override
  State<LoginPasswordPage> createState() => _LoginPasswordPageState();
}

class _LoginPasswordPageState extends State<LoginPasswordPage> {
  late final LoginPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthInjection.loginPasswordController();
    controller.addListener(_refresh);
    controller.init();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _handleBiometricLogin() async {
    final success = await controller.loginWithBiometrics();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Connexion biométrique réussie'
              : 'Connexion biométrique annulée ou échouée',
        ),
      ),
    );
  }

  void _login() {
    final error = controller.validatePassword();

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Connexion avec ${widget.email ?? "votre compte"}',
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biometricState = controller.biometricState;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 440,
            child: AuthHeader(
              showBackButton: true,
              onBack: () => context.pop(),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const SizedBox(height: 140),
                Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthInputField(
                      controller: controller.passwordController,
                      label: 'Mot de passe',
                      hintText: 'Votre mot de passe',
                      obscureText: controller.obscurePassword,
                      suffixIcon: IconButton(
                        onPressed: controller.togglePasswordVisibility,
                        icon: Icon(
                          controller.obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFFB0B8C5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.push('/forgot-password-email');
                        },
                        child: const Text(
                          'Mot de passe oublié?',
                          style: TextStyle(
                            color: Color(0xFF2E3142),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AuthActionButton(
                      label: 'Se connecter',
                      onPressed: _login,
                    ),
                    const SizedBox(height: 20),
                    if (biometricState.isAvailable) ...[
                      BiometricAuthButton(
                        icon: Icons.fingerprint,
                        label: 'Se connecter avec biométrie',
                        onTap: _handleBiometricLogin,
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (biometricState.hasFaceRecognition) ...[
                      BiometricAuthButton(
                        icon: Icons.face_outlined,
                        label: 'Se connecter avec reconnaissance faciale',
                        onTap: _handleBiometricLogin,
                      ),
                      const SizedBox(height: 16),
                    ],
                    AuthSwitchAccountText(
                      isLogin: true,
                      onTap: () {
                        context.go('/register-name');
                      },
                    ),
                    const SizedBox(height: 28),
                    const AuthOrDivider(),
                    const SizedBox(height: 28),
                    AuthSocialRow(
                      onGoogleTap: () {},
                      onAppleTap: () {},
                      onFacebookTap: () {},
                    ),
                  ],
                ),
              ),
            ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}