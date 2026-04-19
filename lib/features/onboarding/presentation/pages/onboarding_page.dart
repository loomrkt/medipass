import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/app_router.dart';
import '../../data/onboarding_items.dart';
import '../widgets/onboarding_button.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_dot_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
  }

  Future<void> _handleNext() async {
    if (_currentIndex < onboardingItems.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await _completeOnboarding();

      if (!mounted) return;
      context.go(AppRouter.loginEmail);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = onboardingItems[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 28),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingItems.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = onboardingItems[index];

                    return OnboardingContent(
                      image: item.image,
                      title: item.title,
                      description: item.description,
                    );
                  },
                ),
              ),
              OnboardingDotIndicator(
                currentIndex: _currentIndex,
                itemCount: onboardingItems.length,
              ),
              const SizedBox(height: 28),
              OnboardingButton(
                text: currentItem.buttonText,
                onPressed: _handleNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}