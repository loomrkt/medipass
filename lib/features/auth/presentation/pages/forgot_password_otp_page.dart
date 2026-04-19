import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/forgot_password_otp_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_otp_field.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  final String email;

  const ForgotPasswordOtpPage({
    super.key,
    required this.email,
  });

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  late final ForgotPasswordOtpController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthInjection.forgotPasswordOtpController();
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

    context.push('/forgot-password-reset');
  }

  void _resend() {
    controller.resendCode();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nouveau code envoyé')),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Entrez le code OTP',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E3142),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nous avons envoyé un code OTP à\nvotre adresse e-mail,\n${widget.email}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF7A869A),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        AuthOtpField(
                          controllers: [
                            controller.otp1Controller,
                            controller.otp2Controller,
                            controller.otp3Controller,
                            controller.otp4Controller,
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Nous vous renverrons le code dans ',
                              style: TextStyle(
                                color: Color(0xFF7A869A),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${controller.timerCountdown} s',
                              style: const TextStyle(
                                color: Color(0xFF2B88F0),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        AuthActionButton(
                          label: 'Continuer',
                          onPressed: _continue,
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            // Clear history and navigate to login email/password pages
                            context.go('/login-email');
                          },
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 14, color: Color(0xFF7A869A)),
                              children: [
                                TextSpan(text: 'Mot de passe retrouvé ? '),
                                TextSpan(
                                  text: 'Se connecter',
                                  style: TextStyle(
                                    color: Color(0xFF2E3142),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
