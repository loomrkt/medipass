import '../../../../core/services/biometric_auth_service.dart';

abstract class BiometricLocalDataSource {
  Future<bool> isBiometricAvailable();
  Future<List<dynamic>> getAvailableBiometrics();
  Future<bool> authenticate({required String reason});
}

class BiometricLocalDataSourceImpl implements BiometricLocalDataSource {
  @override
  Future<bool> isBiometricAvailable() {
    return BiometricAuthService.instance.isBiometricAvailable();
  }

  @override
  Future<List<dynamic>> getAvailableBiometrics() {
    return BiometricAuthService.instance.getAvailableBiometrics();
  }

  @override
  Future<bool> authenticate({required String reason}) {
    return BiometricAuthService.instance.authenticate(reason: reason);
  }
}