import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/assignment.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/utilities/date.dart';
import 'package:togetherly/views/widgets/chore_details_dialog.dart';

class ChoreItem extends StatefulWidget {
  const ChoreItem({super.key, required this.chore});
  final Chore chore;

  @override
  State<ChoreItem> createState() => _ChoreItemState();
}

class _ChoreItemState extends State<ChoreItem> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final List<String> avatars = [
      'bear',
      'cat',
      'chicken',
      'dog',
      'fish',
      'fox',
      'giraffe',
      'gorilla',
      'koala',
      'panda',
      'rabbit',
      'tiger'
    ];

    Widget getStatusIcon(
        ScaffoldProvider scaffoldProvider, ChoreProvider choreProvider) {
      final currentStatus =
          choreProvider.getAssignmentStatusForCurrentUser(widget.chore);
      if (currentStatus == null) {
        throw Exception('No assignment status available for current user');
      } else {
        switch (currentStatus) {
          case AssignmentStatus.assigned:
            return const Icon(
              Icons.check_box_outline_blank,
              size: 28,
              color: AppColors.brandBlack,
            );
          case AssignmentStatus.pending:
            return const Icon(
              Icons.hourglass_bottom,
              size: 28,
              color: AppColors.brandRose,
            );
          case AssignmentStatus.completed:
            return const Icon(
              Icons.check_box_outlined,
              size: 28,
              color: AppColors.brandGreen,
            );
          default:
            throw Exception('Invalid status for chore');
        }
      }
    }

    Future<void> buildDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChoreDetailsDialog(chore: widget.chore);
        },
      );
    }

    Widget assignedAvatars() {
      if (avatars.length > 3) {
        return Row(
          children: <Widget>[
            for (int i = 0; i < 3; ++i)
              Image.asset(
                'assets/images/avatars/${avatars[i]}.png',
                width: 30,
              ),
            Text(
              '+${avatars.length - 3}',
              style: AppTextStyles.brandBodySmall,
            )
          ],
        );
      } else {
        return Row(
          children: avatars
              .map((image) => Image.asset(
                    'assets/images/avatars/$image.png',
                    width: 30,
                  ))
              .toList(),
        );
      }
    }

    Widget pointsAndCheckBox() {
      return Consumer<ChoreProvider>(
        builder: (context, choreProvider, child) => Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.bolt,
                  color: AppColors.brandGold,
                  size: 32,
                ),
                Text(
                  widget.chore.points.toString(),
                  style: AppTextStyles.brandAccent,
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Consumer<ScaffoldProvider>(
              builder: (context, scaffoldProvider, child) => _loading
                  ? const CircularProgressIndicator(
                      color: AppColors.brandPurple,
                    )
                  : IconButton(
                      icon: getStatusIcon(scaffoldProvider, choreProvider),
                      onPressed: () async {
                        setState(() => _loading = true);
                        await choreProvider.toggleChoreCompleted(widget.chore);
                        setState(() => _loading = false);
                      },
                    ),
            ),
          ],
        ),
      );
    }

    return Consumer<ScaffoldProvider>(
      builder: (context, scaffoldProvider, child) => InkWell(
        onTap: () => buildDialog(context),
        child: Container(
          height: 65,
          margin: const EdgeInsets.only(top: 5),
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.brandLightGray,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 6.0, bottom: 6.0, right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // if (chore.isBonus)
                      //   const Icon(
                      //     Icons.star,
                      //     color: AppColors.brandGold,
                      //   ),
                      // if (chore.isBonus)
                      //   const SizedBox(
                      //     width: 5,
                      //   ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.chore.title,
                            style: widget.chore.status == ChoreStatus.pending ||
                                    widget.chore.status == ChoreStatus.completed
                                ? AppTextStyles.brandBodyStrike
                                : AppTextStyles.brandBody,
                          ),
                          if (!widget.chore.dueDate.isToday())
                            Text(
                              widget.chore.dueDate.prettyDate(),
                              style: AppTextStyles.brandAccentSub,
                            ),
                        ],
                      ),
                    ],
                  ),
                  scaffoldProvider.isParentViewingChild
                      ? assignedAvatars()
                      : pointsAndCheckBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
