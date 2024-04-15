import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatelessWidget {
  const ChoreList({super.key, required this.type, required this.isParent});
  final ChoreType type;
  final bool isParent;

  @override
  Widget build(BuildContext context) {
    bool isViewingChild = false;
    Iterable<Chore> getProperChildChores(ChoreProvider provider) {
      return switch (type) {
        ChoreType.today => provider.choresAssignedToPersonIdDueToday,
        ChoreType.comingSoon => provider.choresAssignedToPersonIdComingSoon,
        ChoreType.overdue => provider.choresAssignedToPersonIdOverdue,
      };
    }

    Iterable<Chore> getProperViewedChildChores(ChoreProvider provider) {
      return switch (type) {
        ChoreType.today => provider.choresAssignedToViewedUserDueToday,
        ChoreType.comingSoon => provider.choresAssignedToViewedUserComingSoon,
        ChoreType.overdue => provider.choresAssignedToViewedUserOverdue,
      };
    }

    Iterable<Chore> getProperFamilyChores(ChoreProvider provider) {
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

    Iterable<Chore> getProperList(
        ChoreProvider choreProvider, ScaffoldProvider scaffoldProvider) {
      isViewingChild = scaffoldProvider.childBeingViewed != null;
      return isParent
          ? getProperFamilyChores(choreProvider)
          : isViewingChild
              ? getProperViewedChildChores(choreProvider)
              : getProperChildChores(choreProvider);
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
                if (isParent
                    ? getProperFamilyChores(choreProvider).isEmpty
                    : isViewingChild
                        ? getProperViewedChildChores(choreProvider).isEmpty
                        : getProperChildChores(choreProvider).isEmpty)
                  const Text(
                    'No chores to display here.',
                    style: AppTextStyles.brandAccent,
                  ),
                ...getProperList(choreProvider, scaffoldProvider)
                    .map((chore) => ChoreItem(
                          chore: chore,
                          isParent: isParent,
                        ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
