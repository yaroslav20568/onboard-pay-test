import 'package:app/main.dart' as app;
import 'package:app/services/index.dart';
import 'package:app/widgets/ui/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Paywall Flow', () {
    setUp(() async {
      try {
        await SubscriptionService.clearSubscription();
      } catch (e) {
        debugPrint('Ошибка при очистке подписки: $e');
      }
    });

    testWidgets('должен отображать все элементы paywall экрана', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToPaywall(tester);

      expect(find.text('Выберите подписку'), findsOneWidget);
      expect(find.text('Получите доступ ко всем функциям'), findsOneWidget);
      expect(find.text('Месяц'), findsOneWidget);
      expect(find.text('299 ₽'), findsOneWidget);
      expect(find.text('Год'), findsOneWidget);
      expect(find.text('1999 ₽'), findsOneWidget);
      expect(find.text('Скидка 44%'), findsOneWidget);
      expect(find.text('Продолжить'), findsOneWidget);
    });

    testWidgets(
      'кнопка "Продолжить" должна быть неактивна без выбора подписки',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _navigateToPaywall(tester);

        expect(find.text('Продолжить'), findsOneWidget);

        final buttonFinder = find.byType(Button);
        expect(buttonFinder, findsOneWidget);

        final buttonWidget = tester.widget<Button>(buttonFinder);
        expect(buttonWidget.onPressed, isNull);
      },
    );

    testWidgets('должен выбрать подписку "Месяц" и активировать кнопку', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToPaywall(tester);

      await tester.tap(find.text('Месяц'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.circle_outlined), findsOneWidget);

      final buttonFinder = find.byType(Button);
      final buttonWidget = tester.widget<Button>(buttonFinder);
      expect(buttonWidget.onPressed, isNotNull);
    });

    testWidgets('должен выбрать подписку "Год" и активировать кнопку', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToPaywall(tester);

      await tester.tap(find.text('Год'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.circle_outlined), findsOneWidget);

      final buttonFinder = find.byType(Button);
      final buttonWidget = tester.widget<Button>(buttonFinder);
      expect(buttonWidget.onPressed, isNotNull);
    });

    testWidgets('должен переключиться с "Месяц" на "Год"', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToPaywall(tester);

      await tester.tap(find.text('Месяц'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      await tester.tap(find.text('Год'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.circle_outlined), findsOneWidget);
    });

    testWidgets(
      'должен успешно оплатить подписку "Месяц" и перейти на home_screen',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _navigateToPaywall(tester);

        await tester.tap(find.text('Месяц'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Продолжить'));
        await tester.pumpAndSettle();

        expect(find.text('Выберите подписку'), findsNothing);
        expect(find.text('Добро пожаловать!'), findsOneWidget);
        expect(
          find.text(
            'Вы успешно оформили подписку и получили '
            'доступ ко всем функциям приложения.',
          ),
          findsOneWidget,
        );
        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.text('Месяц'), findsOneWidget);
        expect(find.text('299 ₽'), findsOneWidget);
        expect(find.byIcon(Icons.verified), findsOneWidget);
      },
    );

    testWidgets(
      'должен успешно оплатить подписку "Год" и перейти на home_screen',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _navigateToPaywall(tester);

        await tester.tap(find.text('Год'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Продолжить'));
        await tester.pumpAndSettle();

        expect(find.text('Выберите подписку'), findsNothing);
        expect(find.text('Добро пожаловать!'), findsOneWidget);
        expect(
          find.text(
            'Вы успешно оформили подписку и получили '
            'доступ ко всем функциям приложения.',
          ),
          findsOneWidget,
        );
        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.text('Год'), findsOneWidget);
        expect(find.text('1999 ₽'), findsOneWidget);
        expect(find.text('Скидка 44%'), findsOneWidget);
        expect(find.byIcon(Icons.verified), findsOneWidget);
      },
    );

    testWidgets(
      'должен отображать премиум функции на home_screen после оплаты',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _navigateToPaywall(tester);

        await tester.tap(find.text('Месяц'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Продолжить'));
        await tester.pumpAndSettle();

        expect(find.text('Премиум функции'), findsOneWidget);
        expect(
          find.text('Доступ ко всем премиум функциям приложения'),
          findsOneWidget,
        );
        expect(find.text('Синхронизация'), findsOneWidget);
        expect(
          find.text('Синхронизация данных между устройствами'),
          findsOneWidget,
        );
        expect(find.text('Поддержка'), findsOneWidget);
        expect(
          find.text('Приоритетная поддержка от нашей команды'),
          findsOneWidget,
        );
      },
    );
  });
}

Future<void> _navigateToPaywall(WidgetTester tester) async {
  var attempts = 0;
  const maxAttempts = 5;

  while (find.text('Выберите подписку').evaluate().isEmpty &&
      attempts < maxAttempts) {
    final continueButtons = find.text('Продолжить');
    if (continueButtons.evaluate().isNotEmpty) {
      await tester.tap(continueButtons.first);
      await tester.pumpAndSettle();
      attempts++;
    } else {
      break;
    }
  }
}
