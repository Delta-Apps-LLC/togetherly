import 'package:flutter/material.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatefulWidget {
  const ChoreList({super.key, required this.title, required this.choreList});
  final String title;
  final List<Chore> choreList;

  @override
  State<ChoreList> createState() => _ChoreListState();
}

class _ChoreListState extends State<ChoreList> {

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
          children: widget.choreList.map((chore) {
            return ChoreItem(chore: chore,);
          }).toList(),
        ),
      ],
    );
  }
}
