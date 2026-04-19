import 'package:flutter/material.dart';
import '../../domain/usecases/validate_password_usecase.dart';

class RegisterPasswordController extends ChangeNotifier {
  final ValidatePasswordUseCase validatePasswordUseCase;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  RegisterPasswordController({required this.validatePasswordUseCase});

  String get password => passwordController.text.trim();
  String get confirmPassword => confirmPasswordController.text.trim();

  void init() {}

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }
  
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    notifyListeners();
  }

  String? validate() {
    final passError = validatePasswordUseCase(password);
    if (passError != null) return passError;
    
    if (password != confirmPassword) {
      return 'Les mots de passe ne correspondent pas';
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
