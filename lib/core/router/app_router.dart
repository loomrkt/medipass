import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_email_page.dart';
import '../../features/auth/presentation/pages/login_password_page.dart';
import '../../features/auth/presentation/pages/register_name_page.dart';
import '../../features/auth/presentation/pages/register_email_page.dart';
import '../../features/auth/presentation/pages/register_password_page.dart';
import '../../features/auth/presentation/pages/register_otp_page.dart';
import '../../features/auth/presentation/pages/forgot_password_email_page.dart';
import '../../features/auth/presentation/pages/forgot_password_otp_page.dart';
import '../../features/auth/presentation/pages/forgot_password_reset_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../main_navigation_page.dart';
class AppRouter {
  const AppRouter._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String loginEmail = '/login-email';
  static const String loginPassword = '/login-password';
  static const String registerName = '/register-name';
  static const String registerEmail = '/register-email';
  static const String registerPassword = '/register-password';
  static const String registerOtp = '/register-otp';
  static const String forgotPasswordEmail = '/forgot-password-email';
  static const String forgotPasswordOtp = '/forgot-password-otp';
  static const String forgotPasswordReset = '/forgot-password-reset';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: loginEmail,
        builder: (context, state) => const LoginEmailPage(),
      ),
      GoRoute(
        path: loginPassword,
        builder: (context, state) {
          final email = state.extra as String?;
          return LoginPasswordPage(email: email);
        },
      ),
      GoRoute(
        path: registerName,
        builder: (context, state) => const RegisterNamePage(),
      ),
      GoRoute(
        path: registerEmail,
        builder: (context, state) => const RegisterEmailPage(),
      ),
      GoRoute(
        path: registerPassword,
        builder: (context, state) {
          final email = state.extra as String?;
          return RegisterPasswordPage(email: email);
        },
      ),
      GoRoute(
        path: registerOtp,
        builder: (context, state) {
          final email = state.extra as String?;
          return RegisterOtpPage(email: email);
        },
      ),
      GoRoute(
        path: forgotPasswordEmail,
        builder: (context, state) => const ForgotPasswordEmailPage(),
      ),
      GoRoute(
        path: forgotPasswordOtp,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return ForgotPasswordOtpPage(email: email);
        },
      ),
      GoRoute(
        path: forgotPasswordReset,
        builder: (context, state) => const ForgotPasswordResetPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const MainNavigationPage(),
      ),
    ],
  );
}