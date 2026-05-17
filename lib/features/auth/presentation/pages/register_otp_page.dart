import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';

import '../controllers/register_otp_controller.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_otp_field.dart';
import '../widgets/auth_header.dart';

class RegisterOtpPage extends StatefulWidget {
  final RegistrationData? data;

  const RegisterOtpPage({super.key, this.data});

  @override
  State<RegisterOtpPage> createState() => _RegisterOtpPageState();
}

class _RegisterOtpPageState extends State<RegisterOtpPage> {
  late final RegisterOtpController controller;
  int _resendDelay = 59;
  bool _isResending = false;
  String? _resendMessage;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    controller = RegisterOtpController(widget.data?.email ?? '');
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

  Future<void> _resendCode() async {
    if (_resendDelay > 0 || _isResending) return;

    setState(() {
      _isResending = true;
      _resendMessage = null;
    });

    final result = await controller.resendOtp();

    if (!mounted) return;

    setState(() {
      _isResending = false;
      if (result['success'] == true) {
        _resendMessage = 'Code renvoyé. Vérifiez votre e-mail.';
        _startTimer();
      } else {
        _resendMessage = 'Erreur lors du renvoi : ${result['error']}';
      }
    });

    if (mounted && result['success'] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Le code a été renvoyé.')));
    }
  }

  void _confirm() async {
    final error = controller.validate();

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    try {
      final result = await controller.verifyOtp();
      if (result['success'] == true) {
        // Success! Navigate to Home
        context.go('/home');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: ${result['error']}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    }
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
                          'Nous avons envoyé un code OTP à\nvotre adresse e-mail,\n${widget.data?.email ?? "UserExample@gmail.com"}',
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
                            if (code.length == 6) {
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
                              TextSpan(
                                text: _resendDelay > 0
                                    ? 'Nous vous renverrons le code dans '
                                    : 'Vous pouvez renvoyer le code maintenant.',
                              ),
                              if (_resendDelay > 0)
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
                        if (_resendDelay == 0) ...[
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: _isResending ? null : _resendCode,
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF1976E9),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: _isResending
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('Renvoyer le code'),
                            ),
                          ),
                        ],
                        if (_resendMessage != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            _resendMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2D9CFF),
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
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
