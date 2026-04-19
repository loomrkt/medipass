import 'package:flutter/material.dart';

import '../../domain/entities/biometric_state.dart';
import '../../domain/usecases/authenticate_with_biometrics_usecase.dart';
import '../../domain/usecases/get_biometric_state_usecase.dart';
import '../../domain/usecases/validate_email_usecase.dart';

class LoginEmailController extends ChangeNotifier {
  final GetBiometricStateUseCase getBiometricStateUseCase;
  final AuthenticateWithBiometricsUseCase authenticateWithBiometricsUseCase;
  final ValidateEmailUseCase validateEmailUseCase;

  LoginEmailController({
    required this.getBiometricStateUseCase,
    required this.authenticateWithBiometricsUseCase,
    required this.validateEmailUseCase,
  });

  final TextEditingController emailController = TextEditingController();

  BiometricState biometricState = const BiometricState.empty();
  bool isLoadingBiometric = false;

  Future<void> init() async {
    isLoadingBiometric = true;
    notifyListeners();

    biometricState = await getBiometricStateUseCase();

    isLoadingBiometric = false;
    notifyListeners();
  }

  String? validateEmail() {
    return validateEmailUseCase(emailController.text);
  }

  String get email => emailController.text.trim();

  Future<bool> loginWithBiometrics() {
    return authenticateWithBiometricsUseCase(
      reason: 'Authentifiez-vous pour accéder à votre compte MediPass',
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}