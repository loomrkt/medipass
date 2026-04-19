import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/register_name_controller.dart';
import '../di/auth_injection.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/auth_social_row.dart';
import '../widgets/auth_switch_account_text.dart';
import '../widgets/auth_header.dart';

class RegisterNamePage extends StatefulWidget {
  const RegisterNamePage({super.key});

  @override
  State<RegisterNamePage> createState() => _RegisterNamePageState();
}

class _RegisterNamePageState extends State<RegisterNamePage> {
  late final RegisterNameController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthInjection.registerNameController();
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

    context.push('/register-email', extra: {'name': controller.name, 'surname': controller.surname});
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
            child: AuthHeader(),
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
                      controller: controller.nameController,
                      label: 'Nom',
                      hintText: 'Votre nom',
                    ),
                    const SizedBox(height: 16),
                    AuthInputField(
                      controller: controller.surnameController,
                      label: 'Prenom',
                      hintText: 'Votre prenom',
                    ),
                    const SizedBox(height: 24),
                    AuthActionButton(
                      label: 'Continuer',
                      onPressed: _continue,
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
