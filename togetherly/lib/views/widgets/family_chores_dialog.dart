import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_list.dart';
import 'package:togetherly/views/widgets/filters_dialog.dart';
import 'package:togetherly/views/widgets/new_chore_dialog.dart';

class FamilyChoresDialog extends StatelessWidget {
  const FamilyChoresDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> buildFilterDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const FiltersDialog();
          });
    }

    Future<void> buildChoreDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const NewChoreDialog();
          });
    }

    return Dialog.fullscreen(
      backgroundColor: AppColors.brandWhite,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.transparent,
                  ),
                ),
                Text(
                  'All Chores',
                  style: AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => buildFilterDialog(context),
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        size: 32,
                        color: AppColors.brandBlack,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      onPressed: () => buildChoreDialog(context),
                      icon: const Icon(
                        Icons.add,
                        size: 32,
                        color: AppColors.brandBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SliverFillRemaining(
            child: Padding(
              padding: AppWidgetStyles.appPadding,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ChoreList(
                      home: 'parent',
                      title: 'Today',
                    ),
                    SizedBox(height: 20.0),
                    ChoreList(
                      home: 'child',
                      title: 'Coming Soon',
                    ),
                    SizedBox(height: 20.0),
                    ChoreList(
                      home: 'child',
                      title: 'Overdue',
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
