import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/forgot_password_email_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_header.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  late final ForgotPasswordEmailController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthInjection.forgotPasswordEmailController();
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

    context.push('/forgot-password-otp', extra: controller.email);
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
                          controller: controller.emailController,
                          label: 'Email',
                          hintText: 'votre email',
                          keyboardType: TextInputType.emailAddress,
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
