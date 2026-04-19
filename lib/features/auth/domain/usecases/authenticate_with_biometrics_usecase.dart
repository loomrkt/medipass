import '../repositories/auth_repository.dart';

class AuthenticateWithBiometricsUseCase {
  final AuthRepository repository;

  AuthenticateWithBiometricsUseCase(this.repository);

  Future<bool> call({required String reason}) {
    return repository.authenticateWithBiometrics(reason: reason);
  }
}