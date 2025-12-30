import 'package:app/widgets/home/index.dart';
import 'package:app/widgets/ui/fade_in_animation.dart';
import 'package:flutter/material.dart';

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      const SubscriptionCard(
        icon: Icons.star,
        title: 'Премиум функции',
        description: 'Доступ ко всем премиум функциям приложения',
      ),
      const SubscriptionCard(
        icon: Icons.cloud_done,
        title: 'Синхронизация',
        description: 'Синхронизация данных между устройствами',
      ),
      const SubscriptionCard(
        icon: Icons.support_agent,
        title: 'Поддержка',
        description: 'Приоритетная поддержка от нашей команды',
      ),
    ];

    return Column(
      children: cards.asMap().entries.map((entry) {
        final index = entry.key;
        final card = entry.value;
        return FadeInAnimation(
          delay: Duration(milliseconds: 300 + (index * 150)),
          child: Padding(
            padding: EdgeInsets.only(bottom: index < cards.length - 1 ? 16 : 0),
            child: card,
          ),
        );
      }).toList(),
    );
  }
}
