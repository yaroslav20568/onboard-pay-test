import 'dart:async';

import 'package:app/constants/index.dart';
import 'package:app/models/index.dart';
import 'package:app/screens/index.dart';
import 'package:app/services/index.dart';
import 'package:app/widgets/paywall/paywall_header.dart';
import 'package:app/widgets/paywall/subscription_card.dart';
import 'package:app/widgets/ui/index.dart';
import 'package:flutter/material.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  SubscriptionType? _selectedSubscription;

  static const List<Subscription> _subscriptions = [
    Subscription(
      type: SubscriptionType.month,
      price: SubscriptionConstants.monthPrice,
      discount: 0,
    ),
    Subscription(
      type: SubscriptionType.year,
      price: SubscriptionConstants.yearPrice,
      discount: SubscriptionConstants.yearDiscount,
    ),
  ];

  Future<void> _handlePurchase() async {
    if (_selectedSubscription == null) return;

    await SubscriptionService.setSubscription(true);
    await SubscriptionService.setSubscriptionType(_selectedSubscription!);
    if (mounted) {
      unawaited(
        Navigator.of(context).pushReplacement<void, void>(
          MaterialPageRoute<void>(builder: (context) => const HomeScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const PaywallHeader(),
              Expanded(
                child: Column(
                  children: _subscriptions.map((subscription) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SubscriptionCard(
                        subscription: subscription,
                        isSelected: _selectedSubscription == subscription.type,
                        onTap: () {
                          setState(() {
                            _selectedSubscription = subscription.type;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Button(
                onPressed: _selectedSubscription != null
                    ? _handlePurchase
                    : null,
                variant: ButtonVariant.primary,
                child: const Text('Продолжить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
