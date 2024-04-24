import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/utilities/iterable_extensions.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatelessWidget {
  const ChoreList({super.key, required this.type, required this.chores});
  final ChoreType type;
  final Iterable<Chore> chores;

  @override
  Widget build(BuildContext context) {
    Iterable<Chore> getProperFamilyChores(ChoreProvider provider) {
      return switch (type) {
        ChoreType.today => provider.allChores.dueToday,
        ChoreType.comingSoon => provider.allChores.dueTomorrow,
        ChoreType.overdue => provider.allChores.overdue,
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
          Consumer<ScaffoldProvider>(
            builder: (context, scaffoldProvider, child) => Column(
              children: [
                if (chores.isEmpty)
                  const Text(
                    'No chores to display here.',
                    style: AppTextStyles.brandAccent,
                  ),
                ...chores.map((chore) => ChoreItem(
                      chore: chore,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
