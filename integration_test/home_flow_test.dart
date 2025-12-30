import 'package:app/main.dart' as app;
import 'package:app/services/index.dart';
import 'package:app/widgets/ui/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Screen Flow', () {
    setUp(() async {
      try {
        await SubscriptionService.clearSubscription();
      } catch (e) {
        debugPrint('Ошибка при очистке подписки: $e');
      }
    });

    testWidgets(
      'должен отображать все элементы home_screen с подпиской "Месяц"',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _purchaseSubscription(tester, 'Месяц');

        expect(find.text('Добро пожаловать!'), findsOneWidget);
        expect(
          find.text(
            'Вы успешно оформили подписку и получили '
            'доступ ко всем функциям приложения.',
          ),
          findsOneWidget,
        );
        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.byIcon(Icons.verified), findsOneWidget);
        expect(find.text('Тип подписки'), findsOneWidget);
        expect(find.text('Месяц'), findsOneWidget);
        expect(find.text('Стоимость'), findsOneWidget);
        expect(find.text('299 ₽'), findsOneWidget);
        expect(find.text('Отменить подписку'), findsOneWidget);
      },
    );

    testWidgets(
      'должен отображать все элементы home_screen с подпиской "Год"',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _purchaseSubscription(tester, 'Год');

        expect(find.text('Добро пожаловать!'), findsOneWidget);
        expect(
          find.text(
            'Вы успешно оформили подписку и получили '
            'доступ ко всем функциям приложения.',
          ),
          findsOneWidget,
        );
        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.byIcon(Icons.verified), findsOneWidget);
        expect(find.text('Тип подписки'), findsOneWidget);
        expect(find.text('Год'), findsOneWidget);
        expect(find.text('Стоимость'), findsOneWidget);
        expect(find.text('1999 ₽'), findsOneWidget);
        expect(find.text('Скидка 44%'), findsOneWidget);
        expect(find.text('Отменить подписку'), findsOneWidget);
      },
    );

    testWidgets(
      'должен отображать active_subscription_card с подпиской "Месяц"',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _purchaseSubscription(tester, 'Месяц');

        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.byIcon(Icons.verified), findsOneWidget);
        expect(find.text('Тип подписки'), findsOneWidget);
        expect(find.text('Месяц'), findsWidgets);
        expect(find.text('Стоимость'), findsOneWidget);
        expect(find.text('299 ₽'), findsWidgets);
        expect(find.text('Скидка 44%'), findsNothing);
        expect(find.text('Отменить подписку'), findsOneWidget);

        final cancelButton = find.text('Отменить подписку');
        final buttonFinder = find.ancestor(
          of: cancelButton,
          matching: find.byType(Button),
        );
        expect(buttonFinder, findsOneWidget);

        final buttonWidget = tester.widget<Button>(buttonFinder);
        expect(buttonWidget.onPressed, isNotNull);
      },
    );

    testWidgets(
      'должен отображать active_subscription_card с подпиской "Год"',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _purchaseSubscription(tester, 'Год');

        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.byIcon(Icons.verified), findsOneWidget);
        expect(find.text('Тип подписки'), findsOneWidget);
        expect(find.text('Год'), findsWidgets);
        expect(find.text('Стоимость'), findsOneWidget);
        expect(find.text('1999 ₽'), findsWidgets);
        expect(find.text('Скидка 44%'), findsOneWidget);
        expect(find.text('Отменить подписку'), findsOneWidget);
      },
    );

    testWidgets('должен отображать все премиум функции на home_screen', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await _purchaseSubscription(tester, 'Месяц');

      expect(find.text('Премиум функции'), findsOneWidget);
      expect(
        find.text('Доступ ко всем премиум функциям приложения'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Синхронизация'), findsOneWidget);
      expect(
        find.text('Синхронизация данных между устройствами'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.cloud_done), findsOneWidget);
      expect(find.text('Поддержка'), findsOneWidget);
      expect(
        find.text('Приоритетная поддержка от нашей команды'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.support_agent), findsOneWidget);
    });

    testWidgets(
      'должен отменить подписку "Месяц" и перейти на paywall_screen',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _purchaseSubscription(tester, 'Месяц');

        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.text('Отменить подписку'), findsOneWidget);

        await tester.tap(find.text('Отменить подписку'));
        await tester.pumpAndSettle();

        expect(find.text('Активная подписка'), findsNothing);
        expect(find.text('Добро пожаловать!'), findsNothing);
        expect(find.text('Выберите подписку'), findsOneWidget);
        expect(find.text('Получите доступ ко всем функциям'), findsOneWidget);
        expect(find.text('Месяц'), findsOneWidget);
        expect(find.text('Год'), findsOneWidget);
      },
    );

    testWidgets('должен отменить подписку "Год" и перейти на paywall_screen', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await _purchaseSubscription(tester, 'Год');

      expect(find.text('Активная подписка'), findsOneWidget);
      expect(find.text('Отменить подписку'), findsOneWidget);

      await tester.tap(find.text('Отменить подписку'));
      await tester.pumpAndSettle();

      expect(find.text('Активная подписка'), findsNothing);
      expect(find.text('Добро пожаловать!'), findsNothing);
      expect(find.text('Выберите подписку'), findsOneWidget);
      expect(find.text('Получите доступ ко всем функциям'), findsOneWidget);
      expect(find.text('Месяц'), findsOneWidget);
      expect(find.text('Год'), findsOneWidget);
    });

    testWidgets(
      'должен проверить полный флоу: покупка -> home -> отмена -> paywall',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await _purchaseSubscription(tester, 'Месяц');

        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.text('Добро пожаловать!'), findsOneWidget);
        expect(find.text('Премиум функции'), findsOneWidget);

        await tester.tap(find.text('Отменить подписку'));
        await tester.pumpAndSettle();

        expect(find.text('Выберите подписку'), findsOneWidget);
        expect(find.text('Активная подписка'), findsNothing);

        await tester.tap(find.text('Год'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Продолжить'));
        await tester.pumpAndSettle();

        expect(find.text('Активная подписка'), findsOneWidget);
        expect(find.text('Год'), findsWidgets);
        expect(find.text('1999 ₽'), findsWidgets);
        expect(find.text('Скидка 44%'), findsOneWidget);
      },
    );
  });
}

Future<void> _purchaseSubscription(
  WidgetTester tester,
  String subscriptionType,
) async {
  await _navigateToPaywall(tester);

  await tester.tap(find.text(subscriptionType));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Продолжить'));
  await tester.pumpAndSettle();
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
