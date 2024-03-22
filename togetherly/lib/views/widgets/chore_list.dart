import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatelessWidget {
  const ChoreList({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final List<Chore> choreList = [
      Chore(
        title: 'Test Chore',
        description: 'These are some details about the chore we are testing.',
        dueDate: DateTime(2024, 3, 10),
        points: 10,
        isShared: false,
      ),
      Chore(
        title: 'Test Chore',
        dueDate: DateTime(2024, 3, 10),
        points: 10,
        isShared: false,
      ),
    ];

    List<Chore> getProperList(ChoreProvider provider) {
      return switch (title) {
        'Today' => provider.choreListDueToday,
        'Coming Soon' => provider.choreListComingSoon,
        'Overdue' => provider.choreListOverdue,
        String() => [],
      };
    }

    return Consumer<ChoreProvider>(
      builder: (context, choreProvider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start, // Aligns to center
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns to left
        children: <Widget>[
          Text(
            title,
            style: AppTextStyles.brandAccentLarge,
          ),
          Column(
            children: getProperList(choreProvider)
                .map((chore) => ChoreItem(
                      chore: chore,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
