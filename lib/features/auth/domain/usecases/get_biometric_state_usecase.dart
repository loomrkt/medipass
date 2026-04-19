import '../entities/biometric_state.dart';
import '../repositories/auth_repository.dart';

class GetBiometricStateUseCase {
  final AuthRepository repository;

  GetBiometricStateUseCase(this.repository);

  Future<BiometricState> call() {
    return repository.getBiometricState();
  }
}