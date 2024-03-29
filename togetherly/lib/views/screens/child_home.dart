import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_list.dart';
import 'package:togetherly/views/widgets/edit_chore_dialog.dart';
import 'package:togetherly/views/widgets/points.dart';

class ChildHomePage extends StatelessWidget {
  const ChildHomePage({super.key});

  Future<void> buildDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const EditChoreDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isParent = true; // TODO: replace with provider.isParent

    return Padding(
      padding: AppWidgetStyles.appPadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.add, size: 30, color: Colors.transparent),
                const Points(),
                InkWell(
                  onTap: isParent ? () => buildDialog(context) : null,
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: isParent ? AppColors.brandBlack : Colors.transparent,
                  ),
                ),
              ],
            ),
            const ChoreList(
              home: 'child',
              title: 'Today',
            ),
            const SizedBox(height: 20.0),
            const ChoreList(
              home: 'child',
              title: 'Coming Soon',
            ),
            const SizedBox(height: 20.0),
            const ChoreList(
              home: 'child',
              title: 'Overdue',
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
