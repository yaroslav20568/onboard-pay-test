import 'package:app/models/index.dart';

class SubscriptionConstants {
  static const String monthPrice = '299 ₽';
  static const String yearPrice = '1999 ₽';
  static const int yearDiscount = 44;

  static String getPrice(SubscriptionType type) {
    switch (type) {
      case SubscriptionType.month:
        return monthPrice;
      case SubscriptionType.year:
        return yearPrice;
    }
  }

  static int getDiscount(SubscriptionType type) {
    switch (type) {
      case SubscriptionType.month:
        return 0;
      case SubscriptionType.year:
        return yearDiscount;
    }
  }
}
