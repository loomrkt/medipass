import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPasswordOtpController extends ChangeNotifier {
  final TextEditingController otp1Controller = TextEditingController();
  final TextEditingController otp2Controller = TextEditingController();
  final TextEditingController otp3Controller = TextEditingController();
  final TextEditingController otp4Controller = TextEditingController();

  int timerCountdown = 59;
  Timer? _timer;

  void init() {
    startTimer();
  }

  void startTimer() {
    timerCountdown = 59;
    _timer?.cancel();
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerCountdown > 0) {
        timerCountdown--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  String get otpCode => 
      otp1Controller.text + 
      otp2Controller.text + 
      otp3Controller.text + 
      otp4Controller.text;

  String? validate() {
    if (otpCode.length < 4) {
      return 'Veuillez entrer le code OTP complet.';
    }
    return null;
  }

  void resendCode() {
    if (timerCountdown == 0) {
      startTimer();
      // Appeler le cas d'usage de re-demande d'OTP ici
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    super.dispose();
  }
}
