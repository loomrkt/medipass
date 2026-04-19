import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/forgot_password_reset_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_header.dart';

class ForgotPasswordResetPage extends StatefulWidget {
  const ForgotPasswordResetPage({super.key});

  @override
  State<ForgotPasswordResetPage> createState() =>
      _ForgotPasswordResetPageState();
}

class _ForgotPasswordResetPageState extends State<ForgotPasswordResetPage> {
  late final ForgotPasswordResetController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthInjection.forgotPasswordResetController();
    controller.addListener(_refresh);
    controller.init();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _continue() {
    final error = controller.validate();

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mot de passe réinitialisé avec succès !')),
    );
    
    // Redirect to login after resetting password
    context.go('/login-email');
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
              showBackButton: true,
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
                          label: 'Nouveau mot de passe',
                          hintText: 'Nouveau mot de passe',
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
                        const SizedBox(height: 24),
                        AuthInputField(
                          controller: controller.confirmPasswordController,
                          label: 'Confirmez le mot de passe',
                          hintText: 'Confirmez le mot de passe',
                          obscureText: controller.obscureConfirmPassword,
                          suffixIcon: IconButton(
                            onPressed: controller.toggleConfirmPasswordVisibility,
                            icon: Icon(
                              controller.obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xFFB0B8C5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        AuthActionButton(
                          label: 'Continuer',
                          onPressed: _continue,
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
