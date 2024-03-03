import 'package:flutter/material.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

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
      assignedChildId: 0,
      isShared: false,
    ),
    Chore(
      title: 'Pick up the living room',
      dueDate: DateTime(2024, 2, 14),
      points: 10,
      status: ChoreStatus.pending,
      assignedChildId: 0,
      isShared: false,
    ),
    Chore(
      title: 'Walk the dog',
      dueDate: DateTime(2024, 2, 14),
      points: 20,
      status: ChoreStatus.completed,
      assignedChildId: 0,
      isShared: false,
    ),
  ];

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
        Column(
          children: <Widget>[
            for (final chore in chores) ChoreItem(chore: chore),
          ],
        ),
      ],
    );
  }
}
