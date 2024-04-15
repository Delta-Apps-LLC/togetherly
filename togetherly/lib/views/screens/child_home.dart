import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
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
    bool isParent(ScaffoldProvider provider) {
      return provider.childBeingViewed != null;
    }

    return Consumer<ScaffoldProvider>(
      builder: (context, scaffoldProvider, child) => Padding(
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
                    onTap: isParent(scaffoldProvider)
                        ? () => buildDialog(context)
                        : null,
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: isParent(scaffoldProvider)
                          ? AppColors.brandBlack
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
              const ChoreList(
                type: ChoreType.today,
                isParent: false,
              ),
              const SizedBox(height: 20.0),
              const ChoreList(
                type: ChoreType.comingSoon,
                isParent: false,
              ),
              const SizedBox(height: 20.0),
              const ChoreList(
                type: ChoreType.overdue,
                isParent: false,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
