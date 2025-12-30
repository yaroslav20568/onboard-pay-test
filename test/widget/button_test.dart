import 'package:app/constants/index.dart';
import 'package:app/widgets/ui/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Button', () {
    testWidgets('должен отображать ElevatedButton для primary варианта', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: null,
              variant: ButtonVariant.primary,
              child: Text('Тест'),
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Тест'), findsOneWidget);
    });

    testWidgets('должен отображать OutlinedButton для outline варианта', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: null,
              variant: ButtonVariant.outline,
              child: Text('Тест'),
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Тест'), findsOneWidget);
    });

    testWidgets('должен вызывать onPressed при нажатии', (
      WidgetTester tester,
    ) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: () {
                pressed = true;
              },
              variant: ButtonVariant.primary,
              child: const Text('Тест'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Button));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('не должен вызывать onPressed когда onPressed = null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: null,
              variant: ButtonVariant.primary,
              child: Text('Тест'),
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('должен применять правильные цвета для primary варианта', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: null,
              variant: ButtonVariant.primary,
              child: Text('Тест'),
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final style = button.style;

      final backgroundColor = style?.backgroundColor?.resolve({});
      final foregroundColor = style?.foregroundColor?.resolve({});

      expect(
        backgroundColor,
        AppColors.primary.withValues(alpha: AppColors.disabledOpacity),
      );
      expect(
        foregroundColor,
        AppColors.white.withValues(alpha: AppColors.disabledOpacity),
      );
    });

    testWidgets(
      'должен применять правильные цвета для enabled primary варианта',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button(
                onPressed: () {},
                variant: ButtonVariant.primary,
                child: const Text('Тест'),
              ),
            ),
          ),
        );

        final button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );
        final style = button.style;

        final backgroundColor = style?.backgroundColor?.resolve({});
        final foregroundColor = style?.foregroundColor?.resolve({});

        expect(backgroundColor, AppColors.primary);
        expect(foregroundColor, AppColors.white);
      },
    );

    testWidgets('должен применять правильные цвета для outline варианта', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: null,
              variant: ButtonVariant.outline,
              child: Text('Тест'),
            ),
          ),
        ),
      );

      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final style = button.style;

      final foregroundColor = style?.foregroundColor?.resolve({});
      final side = style?.side?.resolve({});

      expect(
        foregroundColor,
        AppColors.primary.withValues(alpha: AppColors.disabledOpacity),
      );
      expect(
        side?.color,
        AppColors.primary.withValues(alpha: AppColors.disabledOpacity),
      );
    });

    testWidgets(
      'должен применять правильные цвета для enabled outline варианта',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button(
                onPressed: () {},
                variant: ButtonVariant.outline,
                child: const Text('Тест'),
              ),
            ),
          ),
        );

        final button = tester.widget<OutlinedButton>(
          find.byType(OutlinedButton),
        );
        final style = button.style;

        final foregroundColor = style?.foregroundColor?.resolve({});
        final side = style?.side?.resolve({});

        expect(foregroundColor, AppColors.primary);
        expect(side?.color, AppColors.primary);
      },
    );

    testWidgets('должен применять правильный padding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: null,
              variant: ButtonVariant.primary,
              child: Text('Тест'),
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final style = button.style;
      final padding = style?.padding?.resolve({});

      expect(padding, const EdgeInsets.symmetric(horizontal: 24, vertical: 12));
    });

    testWidgets('должен применять правильный borderRadius', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: null,
              variant: ButtonVariant.primary,
              child: Text('Тест'),
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final style = button.style;
      final shape = style?.shape?.resolve({}) as RoundedRectangleBorder?;

      expect(shape?.borderRadius, BorderRadius.circular(8));
    });

    testWidgets('должен отображать переданный child', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Button(
              onPressed: null,
              variant: ButtonVariant.primary,
              child: Text('Кастомный текст'),
            ),
          ),
        ),
      );

      expect(find.text('Кастомный текст'), findsOneWidget);
    });
  });
}
