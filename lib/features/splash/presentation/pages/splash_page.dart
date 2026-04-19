import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/app_router.dart';
import '../widgets/splash_background.dart';
import '../widgets/splash_brand.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    _timer = Timer(const Duration(seconds: 3), _handleNavigation);
  }

  Future<bool> _isUserLoggedIn() async {
    // Par défaut tant qu'il n'y a pas encore d'API :
    return false;
  }

  Future<void> _handleNavigation() async {
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('onboarding_done') ?? false;

    if (!hasSeenOnboarding) {
      if (!mounted) return;
      context.go(AppRouter.onboarding);
      return;
    }

    final isLoggedIn = await _isUserLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      context.go(AppRouter.home);
    } else {
      context.go(AppRouter.loginEmail);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBackground(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: const SplashBrand(),
            ),
          ),
        ),
      ),
    );
  }
}