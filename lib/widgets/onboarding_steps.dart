import 'package:app/constants/colors.dart';
import 'package:app/widgets/app_button.dart';
import 'package:flutter/material.dart';

class OnboardingSteps extends StatefulWidget {
  const OnboardingSteps({super.key});

  @override
  State<OnboardingSteps> createState() => _OnboardingStepsState();
}

class _OnboardingStepsState extends State<OnboardingSteps> {
  int _currentStep = 0;

  final List<OnboardingStepData> _steps = const [
    OnboardingStepData(
      title: 'Добро пожаловать!',
      description:
          'Откройте для себя все возможности нашего приложения. Получите доступ к премиум функциям.',
      icon: Icons.waving_hand,
    ),
    OnboardingStepData(
      title: 'Начните использовать',
      description:
          'Выберите подписку и получите полный доступ ко всем функциям приложения.',
      icon: Icons.rocket_launch,
    ),
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    final isFirstStep = _currentStep == 0;
    final isLastStep = _currentStep == _steps.length - 1;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(step.icon, size: 120, color: AppColors.primary),
                const SizedBox(height: 32),
                Text(
                  step.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  step.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isFirstStep)
                AppButton(
                  onPressed: _previousStep,
                  variant: AppButtonVariant.outline,
                  child: const Text('Предыдущий'),
                )
              else
                const SizedBox.shrink(),
              Row(
                children: List.generate(
                  _steps.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentStep
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(
                              AppColors.inactiveOpacity,
                            ),
                    ),
                  ),
                ),
              ),
              AppButton(
                onPressed: isLastStep
                    ? () {
                        Navigator.of(context).pop();
                      }
                    : _nextStep,
                variant: AppButtonVariant.primary,
                child: const Text('Продолжить'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingStepData {
  const OnboardingStepData({
    required this.title,
    required this.description,
    required this.icon,
  });
  final String title;
  final String description;
  final IconData icon;
}
