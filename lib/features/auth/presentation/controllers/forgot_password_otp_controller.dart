import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPasswordOtpController extends ChangeNotifier {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

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

  String get otpCode => otpControllers.map((c) => c.text).join();

  String? validate() {
    if (otpCode.length < 6) {
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
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
