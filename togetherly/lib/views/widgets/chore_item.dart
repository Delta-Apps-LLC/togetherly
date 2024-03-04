import 'package:flutter/material.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_details_dialog.dart';

class ChoreItem extends StatelessWidget {
  const ChoreItem({super.key, required this.chore});
  final Chore chore;

  @override
  Widget build(BuildContext context) {
    String prettyDate(DateTime dueDate) {
      return "${dueDate.month}/${dueDate.day}/${dueDate.year}";
    }

    DateTime getDateToday() {
      DateTime date = DateTime.now();
      return DateTime(date.year, date.month, date.day);
    }

    bool isDueToday(Chore chore) {
      return chore.dueDate.toString().split(' ')[0] ==
          getDateToday().toString();
    }

    Widget getStatusIcon(Chore chore) {
      switch (chore.status) {
        case ChoreStatus.assigned:
          return const Icon(
            Icons.check_box_outline_blank,
            size: 28,
            color: AppColors.brandBlack,
          );
        case ChoreStatus.pending:
          return const Icon(
            Icons.hourglass_bottom,
            size: 28,
            color: AppColors.brandRose,
          );
        case ChoreStatus.completed:
          return const Icon(
            Icons.check_box_outlined,
            size: 28,
            color: AppColors.brandGreen,
          );
        default:
          throw Exception('Invalid status for chore');
      }
    }

    Future<void> buildDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChoreDetailsDialog(chore: chore);
        },
      );
    }

    return InkWell(
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
                          chore.title,
                          style: chore.status == ChoreStatus.pending ||
                                  chore.status == ChoreStatus.completed
                              ? AppTextStyles.brandBodyStrike
                              : AppTextStyles.brandBody,
                        ),
                        if (!isDueToday(chore))
                          Text(
                            prettyDate(chore.dueDate),
                            style: AppTextStyles.brandAccentSub,
                          ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.bolt,
                      size: 32,
                      color: AppColors.brandGold,
                    ),
                    Text(
                      chore.points.toString(),
                      style: AppTextStyles.brandAccentLarge,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    getStatusIcon(chore),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
