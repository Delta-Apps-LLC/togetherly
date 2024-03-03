import 'package:flutter/material.dart';
import 'package:togetherly/models/child.dart';
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
  List<Child> children = [
    Child(
      id: 1,
      familyId: 1,
      name: 'Emma',
      icon: profileIcon.BEAR,
      totalPoints: 40,
    ),
    Child(
      id: 2,
      familyId: 1,
      name: 'Jacob',
      icon: profileIcon.PANDA,
      totalPoints: 80,
    ),
    Child(
      id: 3,
      familyId: 1,
      name: 'Natalie',
      icon: profileIcon.BEAR,
      totalPoints: 65,
    ),
    Child(
      id: 4,
      familyId: 1,
      name: 'Robert',
      icon: profileIcon.PANDA,
      totalPoints: 35,
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
            for (final child in children) FamilyItem(child: child)
          ],
        ),
      ],
    );
  }
}
