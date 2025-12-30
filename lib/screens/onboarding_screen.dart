import 'package:app/screens/paywall_screen.dart';
import 'package:app/widgets/onboarding_steps.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const List<OnboardingStepData> _steps = [
    OnboardingStepData(
      title: 'Добро пожаловать!',
      description:
          'Откройте для себя все возможности нашего приложения. '
          'Получите доступ к премиум функциям.',
      icon: Icons.waving_hand,
    ),
    OnboardingStepData(
      title: 'Начните использовать',
      description:
          'Выберите подписку и получите полный доступ '
          'ко всем функциям приложения.',
      icon: Icons.rocket_launch,
    ),
  ];

  void _handleComplete(BuildContext context) {
    Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute<void>(builder: (context) => const PaywallScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OnboardingSteps(
          steps: _steps,
          onComplete: () => _handleComplete(context),
        ),
      ),
    );
  }
}
