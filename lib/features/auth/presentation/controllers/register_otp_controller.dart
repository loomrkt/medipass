import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medipass/core/services/auth_service.dart';

class RegisterOtpController extends ChangeNotifier {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final String email;

  RegisterOtpController([this.email = '']);

  String get otpCode => otpControllers.map((c) => c.text).join();

  void init() {}

  String? validate() {
    if (otpCode.length < 6) {
      return 'Veuillez entrer le code OTP complet';
    }
    return null;
  }

  Future<Map<String, dynamic>> verifyOtp() async {
    return await AuthService.instance.verifyOtp(
      email,
      otpCode,
      type: OtpType.signup,
    );
  }

  Future<Map<String, dynamic>> resendOtp() async {
    if (email.isEmpty) {
      return {'success': false, 'error': 'Email manquant'};
    }
    return await AuthService.instance.resendOtp(email);
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
