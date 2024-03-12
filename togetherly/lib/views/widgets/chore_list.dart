import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatelessWidget {
  const ChoreList({super.key, required this.home});
  final String home;

  @override
  Widget build(BuildContext context) {
    final List<Chore> choreList = [
      Chore(
        assignedChildId: 1,
        title: 'Test Chore',
        description: 'These are some details about the chore we are testing.',
        dueDate: DateTime(2024, 3, 10),
        points: 10,
        isShared: false,
      ),
      Chore(
        assignedChildId: 1,
        title: 'Test Chore',
        dueDate: DateTime(2024, 3, 10),
        points: 10,
        isShared: false,
      ),
    ];

    return Consumer<ChoreProvider>(
      builder: (context, provider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start, // Aligns to center
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns to left
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              'All Chores',
              style: AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
            ),
          ),
          const Text(
            'Today',
            style: AppTextStyles.brandAccentLarge,
          ),
          Column(
            children: choreList.map((chore) {
              // TODO: provider.choreList
              return ChoreItem(
                chore: chore,
                home: home,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
