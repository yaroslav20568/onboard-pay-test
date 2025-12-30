import 'dart:async';

import 'package:app/constants/subscription_const.dart';
import 'package:app/models/subscription.dart';
import 'package:app/screens/paywall_screen.dart';
import 'package:app/services/subscription_service.dart';
import 'package:app/widgets/home/active_subscription_card.dart';
import 'package:app/widgets/home/subscription_list.dart';
import 'package:app/widgets/home/welcome_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Subscription? _subscription;

  @override
  void initState() {
    super.initState();
    _loadSubscription();
  }

  Future<void> _loadSubscription() async {
    final hasSubscription = await SubscriptionService.hasSubscription();
    if (!hasSubscription) return;

    final type = await SubscriptionService.getSubscriptionType();
    if (type == null) return;

    setState(() {
      _subscription = Subscription(
        type: type,
        price: SubscriptionConstants.getPrice(type),
        discount: SubscriptionConstants.getDiscount(type),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_subscription != null)
                ActiveSubscriptionCard(
                  subscription: _subscription!,
                  onCancel: _handleClearSubscription,
                ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeSection(),
                    SizedBox(height: 32),
                    SubscriptionList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleClearSubscription() async {
    await SubscriptionService.clearSubscription();
    if (mounted) {
      unawaited(
        Navigator.of(context).pushReplacement<void, void>(
          MaterialPageRoute<void>(builder: (context) => const PaywallScreen()),
        ),
      );
    }
  }
}
