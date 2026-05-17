import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/mocks/mock_data.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/auth_service.dart';
import '../controllers/register_password_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/auth_social_row.dart';
import '../widgets/auth_switch_account_text.dart';
import '../widgets/auth_header.dart';

class RegisterPasswordPage extends StatefulWidget {
  final RegistrationData? data;

  const RegisterPasswordPage({super.key, this.data});

  @override
  State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  late final RegisterPasswordController controller;
  bool _isLoading = false;

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

  void _register() async {
    final navigator = GoRouter.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() => _isLoading = true);

    final error = controller.validate();

    if (error != null) {
      if (mounted) {
        setState(() => _isLoading = false);
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(error)));
      }
      return;
    }

    try {
      final result = await AuthService.instance.register(
        widget.data?.email ?? '',
        controller.password,
        name: widget.data?.name,
      );

      if (result['success'] == true) {
        if (mounted) {
          navigator.push('/register-otp', extra: widget.data);
        }
      } else {
        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(result['error'] ?? 'Inscription échouée'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Une erreur est survenue : $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                        const SizedBox(height: 24),
                        AuthActionButton(
                          label: "S'inscrire",
                          onPressed: _register,
                          isLoading: _isLoading,
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
