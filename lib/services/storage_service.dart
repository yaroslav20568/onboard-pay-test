import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keySubscriptionActive = 'subscription_active';

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingCompleted, true);
  }

  Future<bool> isSubscriptionActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySubscriptionActive) ?? false;
  }

  Future<void> setSubscriptionActive(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySubscriptionActive, value);
  }
}
