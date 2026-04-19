import '../../domain/entities/biometric_state.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/biometric_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BiometricLocalDataSource biometricLocalDataSource;

  AuthRepositoryImpl({
    required this.biometricLocalDataSource,
  });

  @override
  Future<BiometricState> getBiometricState() async {
    final available =
        await biometricLocalDataSource.isBiometricAvailable();
    final biometrics =
        await biometricLocalDataSource.getAvailableBiometrics();

    final hasFace = biometrics.any(
      (b) => b.name.toLowerCase().contains('face'),
    );

    return BiometricState(
      isAvailable: available,
      hasFaceRecognition: hasFace,
    );
  }

  @override
  Future<bool> authenticateWithBiometrics({
    required String reason,
  }) {
    return biometricLocalDataSource.authenticate(reason: reason);
  }
}