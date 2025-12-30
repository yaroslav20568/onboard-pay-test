import 'package:app/models/subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService {
  static const String _subscriptionKey = 'has_subscription';
  static const String _subscriptionTypeKey = 'subscription_type';

  static Future<bool> hasSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_subscriptionKey) ?? false;
  }

  static Future<void> setSubscription(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_subscriptionKey, value);
  }

  static Future<void> setSubscriptionType(SubscriptionType type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_subscriptionTypeKey, type.name);
  }

  static Future<SubscriptionType?> getSubscriptionType() async {
    final prefs = await SharedPreferences.getInstance();
    final typeString = prefs.getString(_subscriptionTypeKey);
    if (typeString == null) return null;
    return SubscriptionType.values.firstWhere(
      (type) => type.name == typeString,
      orElse: () => SubscriptionType.month,
    );
  }

  static Future<void> clearSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_subscriptionKey);
    await prefs.remove(_subscriptionTypeKey);
  }
}
