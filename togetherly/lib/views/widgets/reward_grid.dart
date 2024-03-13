import 'package:flutter/material.dart';
import 'package:togetherly/views/widgets/reward_item.dart';

class RewardGrid extends StatelessWidget {
  const RewardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> rewardsList = [
      {
        'title': 'Ice cream treat',
        'description': '\u{1F366}',
        'points': 20,
      },
      {
        'title': 'Trampoline park',
        'description': '\u{1F9F4}',
        'points': 50,
      },
      {
        'title': 'Party with friends',
        'description': '\u{1F389}',
        'points': 200,
      },
      {
        'title': 'Movie night',
        'description': '\u{1F4F7}',
        'points': 30,
      },
      {
        'title': 'Ice cream treat',
        'description': '\u{1F366}',
        'points': 20,
      },
      {
        'title': 'Trampoline park',
        'description': '\u{1F9F4}',
        'points': 50,
      },
      {
        'title': 'Party with friends',
        'description': '\u{1F389}',
        'points': 200,
      },
      {
        'title': 'Movie night',
        'description': '\u{1F4F7}',
        'points': 30,
      },
      {
        'title': 'Ice cream treat',
        'description': '\u{1F366}',
        'points': 20,
      },
      {
        'title': 'Trampoline park',
        'description': '\u{1F9F4}',
        'points': 50,
      },
      {
        'title': 'Party with friends',
        'description': '\u{1F389}',
        'points': 200,
      },
      {
        'title': 'Movie night',
        'description': '\u{1F4F7}',
        'points': 30,
      },
      {
        'title': 'Ice cream treat',
        'description': '\u{1F366}',
        'points': 20,
      },
      {
        'title': 'Trampoline park',
        'description': '\u{1F9F4}',
        'points': 50,
      },
      {
        'title': 'Party with friends',
        'description': '\u{1F389}',
        'points': 200,
      },
      {
        'title': 'Movie night',
        'description': '\u{1F4F7}',
        'points': 30,
      },
      {
        'title': 'Ice cream treat',
        'description': '\u{1F366}',
        'points': 20,
      },
      {
        'title': 'Trampoline park',
        'description': '\u{1F9F4}',
        'points': 50,
      },
      {
        'title': 'Party with friends',
        'description': '\u{1F389}',
        'points': 200,
      },
      {
        'title': 'Movie night',
        'description': '\u{1F4F7}',
        'points': 30,
      },
      {
        'title': 'Ice cream treat',
        'description': '\u{1F366}',
        'points': 20,
      },
      {
        'title': 'Trampoline park',
        'description': '\u{1F9F4}',
        'points': 50,
      },
      {
        'title': 'Party with friends',
        'description': '\u{1F389}',
        'points': 200,
      },
      {
        'title': 'Movie night',
        'description': '\u{1F4F7}',
        'points': 30,
      },
    ];

    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 2,
          runSpacing: 2,
          children:
              rewardsList.map((reward) => RewardItem(reward: reward)).toList(),
        ),
      ),
    );
  }
}
