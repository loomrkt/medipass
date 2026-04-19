import '../../data/datasources/biometric_local_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/authenticate_with_biometrics_usecase.dart';
import '../../domain/usecases/get_biometric_state_usecase.dart';
import '../../domain/usecases/validate_email_usecase.dart';
import '../../domain/usecases/validate_password_usecase.dart';
import '../controllers/login_email_controller.dart';
import '../controllers/login_password_controller.dart';
import '../controllers/register_name_controller.dart';
import '../controllers/register_email_controller.dart';
import '../controllers/register_password_controller.dart';
import '../controllers/register_otp_controller.dart';
import '../controllers/forgot_password_email_controller.dart';
import '../controllers/forgot_password_otp_controller.dart';
import '../controllers/forgot_password_reset_controller.dart';

class AuthInjection {
  static LoginEmailController loginEmailController() {
    final dataSource = BiometricLocalDataSourceImpl();
    final repository = AuthRepositoryImpl(
      biometricLocalDataSource: dataSource,
    );

    return LoginEmailController(
      getBiometricStateUseCase: GetBiometricStateUseCase(repository),
      authenticateWithBiometricsUseCase:
          AuthenticateWithBiometricsUseCase(repository),
      validateEmailUseCase: ValidateEmailUseCase(),
    );
  }

  static LoginPasswordController loginPasswordController() {
    final dataSource = BiometricLocalDataSourceImpl();
    final repository = AuthRepositoryImpl(
      biometricLocalDataSource: dataSource,
    );

    return LoginPasswordController(
      getBiometricStateUseCase: GetBiometricStateUseCase(repository),
      authenticateWithBiometricsUseCase:
          AuthenticateWithBiometricsUseCase(repository),
      validatePasswordUseCase: ValidatePasswordUseCase(),
    );
  }

  static RegisterNameController registerNameController() {
    return RegisterNameController();
  }

  static RegisterEmailController registerEmailController() {
    return RegisterEmailController(
      validateEmailUseCase: ValidateEmailUseCase(),
    );
  }

  static RegisterPasswordController registerPasswordController() {
    return RegisterPasswordController(
      validatePasswordUseCase: ValidatePasswordUseCase(),
    );
  }

  static RegisterOtpController registerOtpController() {
    return RegisterOtpController();
  }

  static ForgotPasswordEmailController forgotPasswordEmailController() {
    return ForgotPasswordEmailController(
      validateEmailUseCase: ValidateEmailUseCase(),
    );
  }

  static ForgotPasswordOtpController forgotPasswordOtpController() {
    return ForgotPasswordOtpController();
  }

  static ForgotPasswordResetController forgotPasswordResetController() {
    return ForgotPasswordResetController(
      validatePasswordUseCase: ValidatePasswordUseCase(),
    );
  }
}