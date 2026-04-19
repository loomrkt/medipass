import 'package:flutter/material.dart';
import '../../domain/usecases/validate_email_usecase.dart';

class RegisterEmailController extends ChangeNotifier {
  final ValidateEmailUseCase validateEmailUseCase;
  final TextEditingController emailController = TextEditingController();

  RegisterEmailController({required this.validateEmailUseCase});

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
