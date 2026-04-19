import 'package:flutter/material.dart';

class RegisterOtpController extends ChangeNotifier {
  final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());
  
  String get otpCode => otpControllers.map((c) => c.text).join();

  void init() {}

  String? validate() {
    if (otpCode.length < 4) {
      return 'Veuillez entrer le code OTP complet';
    }
    return null;
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
