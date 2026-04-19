import 'package:flutter/material.dart';

import '../../domain/entities/biometric_state.dart';
import '../../domain/usecases/authenticate_with_biometrics_usecase.dart';
import '../../domain/usecases/get_biometric_state_usecase.dart';
import '../../domain/usecases/validate_password_usecase.dart';

class LoginPasswordController extends ChangeNotifier {
  final GetBiometricStateUseCase getBiometricStateUseCase;
  final AuthenticateWithBiometricsUseCase authenticateWithBiometricsUseCase;
  final ValidatePasswordUseCase validatePasswordUseCase;

  LoginPasswordController({
    required this.getBiometricStateUseCase,
    required this.authenticateWithBiometricsUseCase,
    required this.validatePasswordUseCase,
  });

  final TextEditingController passwordController = TextEditingController();

  BiometricState biometricState = const BiometricState.empty();
  bool isLoadingBiometric = false;
  bool obscurePassword = true;

  Future<void> init() async {
    isLoadingBiometric = true;
    notifyListeners();

    biometricState = await getBiometricStateUseCase();

    isLoadingBiometric = false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  String? validatePassword() {
    return validatePasswordUseCase(passwordController.text);
  }

  String get password => passwordController.text.trim();

  Future<bool> loginWithBiometrics() {
    return authenticateWithBiometricsUseCase(
      reason: 'Authentifiez-vous pour vous connecter à MediPass',
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}