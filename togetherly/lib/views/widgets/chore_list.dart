// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/themes.dart';

enum RequestedChores {
  TODAY,
  UPCOMING,
  OVERDUE
}
// toUpperCase() with title to match?

class ChoreList extends StatefulWidget {
  const ChoreList({super.key, required this.title});
  final String title;

  @override
  State<ChoreList> createState() => _ChoreListState();
}

class _ChoreListState extends State<ChoreList> {
  List<Chore> chores = [
    Chore(
      title: 'Do the dishes',
      dueDate: DateTime(2024, 2, 15),
      points: 15,
      isBonus: false,
    ),
    Chore(
      title: 'Pick up the living room',
      dueDate: DateTime(2024, 2, 14),
      points: 10,
      isBonus: false,
      status: ChoreStatus.PENDING,
    ),
    Chore(
      title: 'Walk the dog',
      dueDate: DateTime(2024, 2, 14),
      points: 20,
      isBonus: true,
      status: ChoreStatus.COMPLETED,
    ),
  ];

  String prettyDate(DateTime dueDate) {
    return "${dueDate.month}/${dueDate.day}/${dueDate.year}";
  }

  DateTime getDateToday() {
    DateTime date = DateTime.now();
    return DateTime(date.year, date.month, date.day);
  }

  bool isDueToday(Chore chore) {
    return chore.dueDate == getDateToday();
  }

  Widget getStatusIcon(Chore chore) {
    switch (chore.status) {
      case ChoreStatus.ASSIGNED:
        return const Icon(
          Icons.check_box_outline_blank,
          size: 28,
          color: AppColors.brandBlack,
        );
      case ChoreStatus.PENDING:
        return const Icon(
          Icons.hourglass_bottom,
          size: 28,
          color: AppColors.brandRose,
        );
      case ChoreStatus.COMPLETED:
        return const Icon(
          Icons.check_box_outlined,
          size: 28,
          color: AppColors.brandGreen,
        );
      default:
        throw Exception('Invalid status for chore');
    }
  }

  Widget buildChoreElements() {
    return Column(
      children: <Widget>[
        for (final chore in chores)
          Container(
            height: 65,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.brandLightGray,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 6.0, bottom: 6.0, right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      if (chore.isBonus)
                        const Icon(
                          Icons.star,
                          color: AppColors.brandGold,
                        ),
                      if (chore.isBonus)
                        const SizedBox(
                          width: 5,
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chore.title,
                            style: chore.status == ChoreStatus.PENDING ||
                                    chore.status == ChoreStatus.COMPLETED
                                ? AppTextStyles.brandBodyStrike
                                : AppTextStyles.brandBody,
                          ),
                          if (isDueToday(chore))
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // Aligns to center
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns to left
      children: <Widget>[
        Text(
          widget.title,
          style: AppTextStyles.brandAccentLarge,
        ),
        buildChoreElements(),
      ],
    );
  }
}
