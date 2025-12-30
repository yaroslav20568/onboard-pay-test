import 'package:app/constants/index.dart';
import 'package:app/screens/index.dart';
import 'package:app/services/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnboardPay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const InitialScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool _isLoading = true;
  bool _hasSubscription = false;

  @override
  void initState() {
    super.initState();

    _checkSubscription();
  }

  Future<void> _checkSubscription() async {
    final hasSubscription = await SubscriptionService.hasSubscription();

    if (mounted) {
      setState(() {
        _hasSubscription = hasSubscription;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return _hasSubscription ? const HomeScreen() : const OnboardingScreen();
  }
}
