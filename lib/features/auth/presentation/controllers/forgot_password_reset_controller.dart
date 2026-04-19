import 'package:flutter/material.dart';
import '../../domain/usecases/validate_password_usecase.dart';

class ForgotPasswordResetController extends ChangeNotifier {
  final ValidatePasswordUseCase validatePasswordUseCase;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  ForgotPasswordResetController({required this.validatePasswordUseCase});

  void init() {}

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  String get password => passwordController.text;
  String get confirmPassword => confirmPasswordController.text;

  String? validate() {
    final passError = validatePasswordUseCase(password);
    if (passError != null) return passError;

    if (password != confirmPassword) {
      return 'Les mots de passe ne correspondent pas.';
    }

    return null;
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
