import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/reward_provider.dart';
import 'package:togetherly/views/widgets/reward_item.dart';

class RewardGrid extends StatelessWidget {
  const RewardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardProvider>(
      builder: (context, rewardProvider, child) => Expanded(
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 2,
            runSpacing: 2,
            children: rewardProvider.rewards
                .map((reward) => RewardItem(reward: reward))
                .toList(),
          ),
        ),
      ),
    );
  }
}
