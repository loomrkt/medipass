import 'package:flutter/material.dart';
import '../../domain/usecases/validate_email_usecase.dart';

class ForgotPasswordEmailController extends ChangeNotifier {
  final ValidateEmailUseCase validateEmailUseCase;
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordEmailController({required this.validateEmailUseCase});

  String get email => emailController.text.trim();

  void init() {}

  String? validate() {
    return validateEmailUseCase(email);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
