enum SubscriptionType { month, year }

class Subscription {
  const Subscription({
    required this.type,
    required this.price,
    required this.discount,
  });

  final SubscriptionType type;
  final String price;
  final int discount;

  String get title {
    switch (type) {
      case SubscriptionType.month:
        return 'Месяц';
      case SubscriptionType.year:
        return 'Год';
    }
  }

  String get discountText {
    if (discount > 0) {
      return 'Скидка $discount%';
    }

    return '';
  }
}
