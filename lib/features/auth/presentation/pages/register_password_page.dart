import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/register_password_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/auth_social_row.dart';
import '../widgets/auth_switch_account_text.dart';
import '../widgets/auth_header.dart';

class RegisterPasswordPage extends StatefulWidget {
  final String? email;

  const RegisterPasswordPage({super.key, this.email});

  @override
  State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  late final RegisterPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthInjection.registerPasswordController();
    controller.addListener(_refresh);
    controller.init();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _register() {
    final error = controller.validate();

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    context.push('/register-otp', extra: widget.email);
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
                      obscureText: controller.isPasswordObscured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFFC0C4CC),
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AuthInputField(
                      controller: controller.confirmPasswordController,
                      label: 'Confirmez le mot de passe',
                      hintText: 'Confirmez votre mot de passe',
                      obscureText: controller.isConfirmPasswordObscured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFFC0C4CC),
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AuthActionButton(
                      label: "S'inscrire",
                      onPressed: _register,
                    ),
                    const SizedBox(height: 28),
                    AuthSwitchAccountText(
                      isLogin: false,
                      onTap: () {
                        context.go('/login-email');
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
