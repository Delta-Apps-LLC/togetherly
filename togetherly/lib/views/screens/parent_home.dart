import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_list.dart';
import 'package:togetherly/views/widgets/family_chores_dialog.dart';
import 'package:togetherly/views/widgets/family_list.dart';
import 'package:togetherly/views/widgets/edit_chore_dialog.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> openChoreOverview(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const FamilyChoresDialog();
          });
    }

    Future<void> buildChoreDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const EditChoreDialog();
        },
      );
    }

    return Padding(
      padding: AppWidgetStyles.appPadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const FamilyList(title: 'Members'),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Invisible grouping to make sure the title is centered
                const Row(
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.add,
                        size: 32,
                        color: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        size: 32,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                Text(
                  'All Chores',
                  style: AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => buildChoreDialog(context),
                      icon: const Icon(
                        Icons.add,
                        size: 32,
                        color: AppColors.brandBlack,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      onPressed: () => openChoreOverview(context),
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 32,
                        color: AppColors.brandBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const ChoreList(
              title: 'Today',
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
