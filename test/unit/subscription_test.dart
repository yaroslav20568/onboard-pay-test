import 'package:app/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Subscription', () {
    group('title', () {
      test('должен возвращать "Месяц" для типа month', () {
        const subscription = Subscription(
          type: SubscriptionType.month,
          price: '100',
          discount: 0,
        );

        expect(subscription.title, 'Месяц');
      });

      test('должен возвращать "Год" для типа year', () {
        const subscription = Subscription(
          type: SubscriptionType.year,
          price: '1000',
          discount: 0,
        );

        expect(subscription.title, 'Год');
      });
    });

    group('discountText', () {
      test('должен возвращать "Скидка X%" когда discount > 0', () {
        const subscription = Subscription(
          type: SubscriptionType.month,
          price: '100',
          discount: 20,
        );

        expect(subscription.discountText, 'Скидка 20%');
      });

      test('должен возвращать "Скидка 1%" для discount = 1', () {
        const subscription = Subscription(
          type: SubscriptionType.month,
          price: '100',
          discount: 1,
        );

        expect(subscription.discountText, 'Скидка 1%');
      });

      test('должен возвращать "Скидка 100%" для discount = 100', () {
        const subscription = Subscription(
          type: SubscriptionType.month,
          price: '100',
          discount: 100,
        );

        expect(subscription.discountText, 'Скидка 100%');
      });

      test('должен возвращать пустую строку когда discount = 0', () {
        const subscription = Subscription(
          type: SubscriptionType.month,
          price: '100',
          discount: 0,
        );

        expect(subscription.discountText, '');
      });

      test('должен возвращать пустую строку когда discount < 0', () {
        const subscription = Subscription(
          type: SubscriptionType.month,
          price: '100',
          discount: -10,
        );

        expect(subscription.discountText, '');
      });
    });
  });
}
