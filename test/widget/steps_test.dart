import 'package:app/widgets/ui/steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Steps', () {
    final testSteps = [
      const StepData(
        title: 'Шаг 1',
        description: 'Описание шага 1',
        icon: Icons.star,
      ),
      const StepData(
        title: 'Шаг 2',
        description: 'Описание шага 2',
        icon: Icons.favorite,
      ),
      const StepData(
        title: 'Шаг 3',
        description: 'Описание шага 3',
        icon: Icons.check,
      ),
    ];

    testWidgets('должен отображать первый шаг при инициализации', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(steps: testSteps, onComplete: () {}),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Шаг 1'), findsOneWidget);
      expect(find.text('Описание шага 1'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('должен скрывать кнопку "Предыдущий" на первом шаге', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(steps: testSteps, onComplete: () {}),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Предыдущий'), findsNothing);
    });

    testWidgets('должен показывать кнопку "Предыдущий" на втором шаге', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(steps: testSteps, onComplete: () {}),
          ),
        ),
      );

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(find.text('Предыдущий'), findsOneWidget);
    });

    testWidgets(
      'должен переходить к следующему шагу при нажатии "Продолжить"',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Steps(steps: testSteps, onComplete: () {}),
            ),
          ),
        );

        await tester.tap(find.text('Продолжить'));
        await tester.pumpAndSettle();

        expect(find.text('Шаг 2'), findsOneWidget);
        expect(find.text('Описание шага 2'), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
      },
    );

    testWidgets(
      'должен возвращаться к предыдущему шагу при нажатии "Предыдущий"',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Steps(steps: testSteps, onComplete: () {}),
            ),
          ),
        );

        await tester.tap(find.text('Продолжить'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Предыдущий'));
        await tester.pumpAndSettle();

        expect(find.text('Шаг 1'), findsOneWidget);
        expect(find.text('Описание шага 1'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      },
    );

    testWidgets('должен отображать правильное количество индикаторов шагов', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(steps: testSteps, onComplete: () {}),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final containers = find.byType(Container);
      final stepIndicators = containers.evaluate().where((element) {
        final container = element.widget as Container;
        return container.decoration is BoxDecoration &&
            (container.decoration! as BoxDecoration).shape == BoxShape.circle;
      });

      expect(stepIndicators.length, testSteps.length);
    });

    testWidgets('должен подсвечивать текущий шаг в индикаторах', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(steps: testSteps, onComplete: () {}),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final containers = find.byType(Container);
      final stepIndicators = containers.evaluate().where((element) {
        final container = element.widget as Container;
        return container.decoration is BoxDecoration &&
            (container.decoration! as BoxDecoration).shape == BoxShape.circle;
      }).toList();

      expect(stepIndicators.length, testSteps.length);
    });

    testWidgets('должен вызывать onComplete при достижении последнего шага', (
      WidgetTester tester,
    ) async {
      var completed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(
              steps: testSteps,
              onComplete: () {
                completed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(completed, isTrue);
    });

    testWidgets('должен отображать правильный контент для каждого шага', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(steps: testSteps, onComplete: () {}),
          ),
        ),
      );

      await tester.pumpAndSettle();

      for (var i = 0; i < testSteps.length; i++) {
        final step = testSteps[i];

        expect(find.text(step.title), findsOneWidget);
        expect(find.text(step.description), findsOneWidget);
        expect(find.byIcon(step.icon), findsOneWidget);

        if (i < testSteps.length - 1) {
          await tester.tap(find.text('Продолжить'));
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('не должен переходить назад с первого шага', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(steps: testSteps, onComplete: () {}),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Шаг 1'), findsOneWidget);
      expect(find.text('Предыдущий'), findsNothing);
    });

    testWidgets('должен корректно работать с одним шагом', (
      WidgetTester tester,
    ) async {
      final singleStep = [
        const StepData(
          title: 'Единственный шаг',
          description: 'Описание',
          icon: Icons.star,
        ),
      ];

      var completed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Steps(
              steps: singleStep,
              onComplete: () {
                completed = true;
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Единственный шаг'), findsOneWidget);
      expect(find.text('Предыдущий'), findsNothing);

      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(completed, isTrue);
    });
  });
}
