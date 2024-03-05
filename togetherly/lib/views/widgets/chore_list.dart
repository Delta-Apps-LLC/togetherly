import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatelessWidget {
  const ChoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChoreProvider>(
      builder: (context, provider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start, // Aligns to center
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns to left
        children: <Widget>[
          const Text(
            'Today',
            style: AppTextStyles.brandAccentLarge,
          ),
          Column(
            children: provider.choreList.map((chore) {
              return ChoreItem(
                chore: chore,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
