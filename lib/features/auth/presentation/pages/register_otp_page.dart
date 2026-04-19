import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/register_otp_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_otp_field.dart';
import '../widgets/auth_header.dart';

class RegisterOtpPage extends StatefulWidget {
  final String? email;

  const RegisterOtpPage({super.key, this.email});

  @override
  State<RegisterOtpPage> createState() => _RegisterOtpPageState();
}

class _RegisterOtpPageState extends State<RegisterOtpPage> {
  late final RegisterOtpController controller;
  int _resendDelay = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    controller = AuthInjection.registerOtpController();
    controller.addListener(_refresh);
    controller.init();
    _startTimer();
  }

  void _startTimer() {
    _resendDelay = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendDelay > 0) {
        setState(() {
          _resendDelay--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _confirm() {
    final error = controller.validate();

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    // Success! Navigate to Home or Show success dialog
    context.go('/home');
  }

  @override
  void dispose() {
    _timer?.cancel();
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
                padding: const EdgeInsets.fromLTRB(32, 40, 32, 24),
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
                      'Nous avons envoyé un code OTP à\nvotre adresse e-mail,\n${widget.email ?? "UserExample@gmail.com"}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF7C8593),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 48),
                    AuthOtpField(
                      controllers: controller.otpControllers,
                      onChanged: (code) {
                        if (code.length == 4) {
                           // auto-confirm when full maybe 
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7C8593),
                        ),
                        children: [
                          const TextSpan(
                            text: 'Nous vous renverrons le code dans ',
                          ),
                          TextSpan(
                            text: '$_resendDelay s',
                            style: const TextStyle(
                              color: Color(0xFF2D9CFF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    AuthActionButton(
                      label: 'Confirmer',
                      onPressed: _confirm,
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
