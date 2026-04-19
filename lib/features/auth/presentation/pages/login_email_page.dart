import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/login_email_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/auth_social_row.dart';
import '../widgets/auth_switch_account_text.dart';
import '../widgets/auth_header.dart';
import '../widgets/biometric_auth_button.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  late final LoginEmailController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthInjection.loginEmailController();
    controller.addListener(_refresh);
    controller.init();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _continue() {
    final error = controller.validateEmail();

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    context.push('/login-password', extra: controller.email);
  }

  Future<void> _handleBiometricAuth() async {
    final success = await controller.loginWithBiometrics();
    if (success && mounted) {
      context.go('/home'); // Suppose we go to home on success
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentification biométrique échouée')),
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 440,
            child: AuthHeader(
              showBackButton: false,
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
                          controller: controller.emailController,
                          label: 'Email',
                          hintText: 'votre@email.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 24),
                        AuthActionButton(
                          label: 'Continuer',
                          onPressed: _continue,
                        ),
                        
                        if (!controller.isLoadingBiometric && controller.biometricState.isAvailable) ...[
                          const SizedBox(height: 16),
                          BiometricAuthButton(
                            icon: controller.biometricState.hasFaceRecognition ? Icons.face : Icons.fingerprint,
                            label: controller.biometricState.hasFaceRecognition ? 'Face ID' : 'Touch ID',
                            onTap: _handleBiometricAuth,
                          ),
                        ],
                        
                        const SizedBox(height: 28),
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
