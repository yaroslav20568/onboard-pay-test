import 'package:app/models/index.dart';
import 'package:app/services/subscription_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  });

  group('SubscriptionService', () {
    group('hasSubscription', () {
      test('должен возвращать false когда подписка не установлена', () async {
        final result = await SubscriptionService.hasSubscription();

        expect(result, false);
      });

      test('должен возвращать true когда подписка установлена', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('has_subscription', true);

        final result = await SubscriptionService.hasSubscription();

        expect(result, true);
      });
    });

    group('setSubscription', () {
      test('должен устанавливать подписку в true', () async {
        await SubscriptionService.setSubscription(true);

        final prefs = await SharedPreferences.getInstance();
        final result = prefs.getBool('has_subscription');

        expect(result, true);
      });

      test('должен устанавливать подписку в false', () async {
        await SubscriptionService.setSubscription(false);

        final prefs = await SharedPreferences.getInstance();
        final result = prefs.getBool('has_subscription');

        expect(result, false);
      });
    });

    group('setSubscriptionType', () {
      test('должен устанавливать тип подписки month', () async {
        await SubscriptionService.setSubscriptionType(SubscriptionType.month);

        final prefs = await SharedPreferences.getInstance();
        final result = prefs.getString('subscription_type');

        expect(result, 'month');
      });

      test('должен устанавливать тип подписки year', () async {
        await SubscriptionService.setSubscriptionType(SubscriptionType.year);

        final prefs = await SharedPreferences.getInstance();
        final result = prefs.getString('subscription_type');

        expect(result, 'year');
      });
    });

    group('getSubscriptionType', () {
      test('должен возвращать null когда тип не установлен', () async {
        final result = await SubscriptionService.getSubscriptionType();

        expect(result, null);
      });

      test('должен возвращать month когда установлен month', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('subscription_type', 'month');

        final result = await SubscriptionService.getSubscriptionType();

        expect(result, SubscriptionType.month);
      });

      test('должен возвращать year когда установлен year', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('subscription_type', 'year');

        final result = await SubscriptionService.getSubscriptionType();

        expect(result, SubscriptionType.year);
      });

      test('должен возвращать month когда установлен невалидный тип', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('subscription_type', 'invalid_type');

        final result = await SubscriptionService.getSubscriptionType();

        expect(result, SubscriptionType.month);
      });
    });

    group('clearSubscription', () {
      test('должен удалять has_subscription и subscription_type', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('has_subscription', true);
        await prefs.setString('subscription_type', 'month');

        await SubscriptionService.clearSubscription();

        final hasSubscription = prefs.getBool('has_subscription');
        final subscriptionType = prefs.getString('subscription_type');

        expect(hasSubscription, null);
        expect(subscriptionType, null);
      });

      test('должен работать когда ключи не существуют', () async {
        await SubscriptionService.clearSubscription();

        final prefs = await SharedPreferences.getInstance();
        final hasSubscription = prefs.getBool('has_subscription');
        final subscriptionType = prefs.getString('subscription_type');

        expect(hasSubscription, null);
        expect(subscriptionType, null);
      });
    });
  });
}
