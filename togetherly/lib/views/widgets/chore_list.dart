import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatelessWidget {
  const ChoreList({super.key, required this.type});
  final ChoreType type;

  @override
  Widget build(BuildContext context) {
    Iterable<Chore> getProperChores(ChoreProvider provider) {
      return switch (type) {
        ChoreType.today => provider.choresDueToday,
        ChoreType.comingSoon => provider.choresComingSoon,
        ChoreType.overdue => provider.choresOverdue,
      };
    }

    String getProperChoreTitle() {
      return switch (type) {
        ChoreType.today => 'Today',
        ChoreType.comingSoon => 'Coming Soon',
        ChoreType.overdue => 'Overdue'
      };
    }

    return Consumer<ChoreProvider>(
      builder: (context, choreProvider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center, // Aligns to center
        crossAxisAlignment: CrossAxisAlignment.stretch, // Aligns to left
        // mainAxisAlignment: MainAxisAlignment.start, // Aligns to center
        // crossAxisAlignment: CrossAxisAlignment.start, // Aligns to left
        children: <Widget>[
          Text(
            getProperChoreTitle(),
            style: AppTextStyles.brandAccentLarge,
          ),
          Column(
            children: [
              if (getProperChores(choreProvider).isEmpty)
                const Text(
                  'No chores to display here.',
                  style: AppTextStyles.brandAccent,
                ),
              ...getProperChores(choreProvider).map((chore) => ChoreItem(
                    chore: chore,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
