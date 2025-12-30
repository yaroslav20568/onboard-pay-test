import 'package:app/main.dart' as app;
import 'package:app/services/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding Flow', () {
    setUp(() async {
      try {
        await SubscriptionService.clearSubscription();
      } catch (e) {
        debugPrint('Ошибка при очистке подписки: $e');
      }
    });

    testWidgets('должен пройти весь флоу onboarding и перейти на paywall', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Добро пожаловать!'), findsOneWidget);
      expect(
        find.text(
          'Откройте для себя все возможности нашего приложения. '
          'Получите доступ к премиум функциям.',
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.waving_hand), findsOneWidget);
      expect(find.text('Продолжить'), findsOneWidget);

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(find.text('Начните использовать'), findsOneWidget);
      expect(
        find.text(
          'Выберите подписку и получите полный доступ '
          'ко всем функциям приложения.',
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.rocket_launch), findsOneWidget);
      expect(find.text('Предыдущий'), findsOneWidget);
      expect(find.text('Продолжить'), findsOneWidget);

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(find.text('Выберите подписку'), findsOneWidget);
      expect(find.text('Получите доступ ко всем функциям'), findsOneWidget);
      expect(find.text('Продолжить'), findsOneWidget);
    });

    testWidgets('должен вернуться на предыдущий шаг при нажатии "Предыдущий"', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Добро пожаловать!'), findsOneWidget);

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(find.text('Начните использовать'), findsOneWidget);
      expect(find.text('Предыдущий'), findsOneWidget);

      await tester.tap(find.text('Предыдущий'));
      await tester.pumpAndSettle();

      expect(find.text('Добро пожаловать!'), findsOneWidget);
      expect(find.text('Предыдущий'), findsNothing);
    });

    testWidgets('должен отображать правильные индикаторы шагов', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      final containers = find.byType(Container);
      final stepIndicators = containers.evaluate().where((element) {
        final container = element.widget as Container;
        return container.decoration is BoxDecoration &&
            (container.decoration! as BoxDecoration).shape == BoxShape.circle;
      });

      expect(stepIndicators.length, 2);

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      final containersAfter = find.byType(Container);
      final stepIndicatorsAfter = containersAfter.evaluate().where((element) {
        final container = element.widget as Container;
        return container.decoration is BoxDecoration &&
            (container.decoration! as BoxDecoration).shape == BoxShape.circle;
      });

      expect(stepIndicatorsAfter.length, 2);
    });
  });
}
