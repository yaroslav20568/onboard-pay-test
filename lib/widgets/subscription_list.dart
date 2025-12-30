import 'package:app/widgets/subscription_card.dart';
import 'package:flutter/material.dart';

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SubscriptionCard(
          icon: Icons.star,
          title: 'Премиум функции',
          description: 'Доступ ко всем премиум функциям приложения',
        ),
        SizedBox(height: 16),
        SubscriptionCard(
          icon: Icons.cloud_done,
          title: 'Синхронизация',
          description: 'Синхронизация данных между устройствами',
        ),
        SizedBox(height: 16),
        SubscriptionCard(
          icon: Icons.support_agent,
          title: 'Поддержка',
          description: 'Приоритетная поддержка от нашей команды',
        ),
      ],
    );
  }
}
