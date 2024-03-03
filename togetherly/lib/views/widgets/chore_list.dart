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
      1,
      Child(
        id: 1,
        familyId: 1,
        name: 'Emma',
        icon: profileIcon.BEAR,
        totalPoints: 40,
      ),
      'Do the dishes',
      'Make sure you use soap',
      DateTime(2024, 3, 14),
      10,
      ChoreStatus.assigned,
      false,
    ),
    Chore(
      2,
      Child(
        id: 1,
        familyId: 1,
        name: 'Emma',
        icon: profileIcon.BEAR,
        totalPoints: 40,
      ),
      'Walk the dog',
      '',
      DateTime(2024, 3, 15),
      15,
      ChoreStatus.pending,
      false,
    ),
    Chore(
      3,
      Child(
        id: 1,
        familyId: 1,
        name: 'Emma',
        icon: profileIcon.BEAR,
        totalPoints: 40,
      ),
      'Make your bed',
      '',
      DateTime(2024, 3, 1),
      5,
      ChoreStatus.completed,
      false,
    ),
    Chore(
      4,
      Child(
        id: 1,
        familyId: 1,
        name: 'Emma',
        icon: profileIcon.BEAR,
        totalPoints: 40,
      ),
      'Dust and vacuum the living room',
      'Use a rag and the surface cleaner for dusting, don\'t forget the baseboards',
      DateTime(2024, 3, 3),
      15,
      ChoreStatus.assigned,
      true,
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
