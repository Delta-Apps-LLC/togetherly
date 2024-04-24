import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/utilities/iterable_extensions.dart';
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
    Future<void> refresh() async {
      final choreProvider = Provider.of<ChoreProvider>(context, listen: false);
      await choreProvider.refresh();
    }

    return Consumer<ScaffoldProvider>(
      builder: (context, scaffoldProvider, child) => Padding(
        padding: AppWidgetStyles.appPadding,
        child: RefreshIndicator(
          color: AppColors.brandGreen,
          onRefresh: () => refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Consumer<ChoreProvider>(
              builder: (context, choreProvider, child) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.add,
                          size: 30, color: Colors.transparent),
                      const Points(),
                      InkWell(
                        onTap: scaffoldProvider.isParentViewingChild
                            ? () => buildDialog(context)
                            : null,
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: scaffoldProvider.isParentViewingChild
                              ? AppColors.brandBlack
                              : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  ChoreList(
                    type: ChoreType.today,
                    chores: scaffoldProvider.isParentViewingChild
                        ? choreProvider
                            .choresAssignedToPersonId(
                                scaffoldProvider.childBeingViewed!.id!)
                            .dueToday
                        : choreProvider.choresAssignedToCurrentUser.dueToday,
                  ),
                  const SizedBox(height: 20.0),
                  ChoreList(
                    type: ChoreType.comingSoon,
                    chores: scaffoldProvider.isParentViewingChild
                        ? choreProvider
                            .choresAssignedToPersonId(
                                scaffoldProvider.childBeingViewed!.id!)
                            .dueTomorrow
                        : choreProvider.choresAssignedToCurrentUser.dueTomorrow,
                  ),
                  const SizedBox(height: 20.0),
                  ChoreList(
                    type: ChoreType.overdue,
                    chores: scaffoldProvider.isParentViewingChild
                        ? choreProvider
                            .choresAssignedToPersonId(
                                scaffoldProvider.childBeingViewed!.id!)
                            .overdue
                        : choreProvider.choresAssignedToCurrentUser.overdue,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
