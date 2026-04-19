import '../entities/biometric_state.dart';

abstract class AuthRepository {
  Future<BiometricState> getBiometricState();
  Future<bool> authenticateWithBiometrics({required String reason});
}