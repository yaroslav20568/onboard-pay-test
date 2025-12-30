import 'package:app/constants/index.dart';
import 'package:app/screens/index.dart';
import 'package:app/widgets/ui/index.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const List<StepData> _steps = [
    StepData(
      title: 'Добро пожаловать!',
      description:
          'Откройте для себя все возможности нашего приложения. '
          'Получите доступ к премиум функциям.',
      icon: Icons.waving_hand,
    ),
    StepData(
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: ScreenSpacing.vertical,
                  ),
                  child: Center(
                    child: FadeInAnimation(
                      child: Steps(
                        steps: _steps,
                        onComplete: () => _handleComplete(context),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
