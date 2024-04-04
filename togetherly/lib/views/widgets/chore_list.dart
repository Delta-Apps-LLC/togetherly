import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatelessWidget {
  const ChoreList({super.key, required this.title, required this.isParent});
  final String title;
  final bool isParent;

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center, // Aligns to center
        crossAxisAlignment: CrossAxisAlignment.stretch, // Aligns to left
        children: <Widget>[
          Text(
            title,
            style: AppTextStyles.brandAccentLarge,
          ),
          Column(
            children: [
              if (getProperList(choreProvider).isEmpty)
                const Text(
                  'No chores to display here.',
                  style: AppTextStyles.brandAccent,
                ),
              ...getProperList(choreProvider)
                  .map((chore) => ChoreItem(chore: chore, isParent: isParent))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
