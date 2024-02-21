import 'package:flutter/material.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/family_item.dart';

class FamilyList extends StatefulWidget {
  const FamilyList({super.key, required this.title});
  final String title;

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  List<Person> children = [
    Person(
      name: 'Emma',
      avatar: 1,
      points: 45,
    ),
    Person(
      name: 'Jacob',
      avatar: 2,
      points: 80,
    ),
    Person(
      name: 'Natalie',
      avatar: 3,
      points: 65,
    ),
    Person(
      name: 'Robert',
      avatar: 4,
      points: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // Aligns to center
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns to left
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
            ),
            InkWell(
              onTap: () => {
                // Extract into function above, Dialog for new child
                print('hello there')
              },
              child: const Icon(
                Icons.add,
                size: 30,
                color: AppColors.brandBlack,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            for (final person in children) FamilyItem(member: person)
          ],
        ),
      ],
    );
  }
}
