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
  List<Child> members = const [
    Child(
      familyId: 0,
      name: 'Emma',
      icon: ProfileIcon.bear,
      totalPoints: 45,
    ),
    Child(
      familyId: 0,
      name: 'Jacob',
      icon: ProfileIcon.dog,
      totalPoints: 80,
    ),
    Child(
      familyId: 0,
      name: 'Natalie',
      icon: ProfileIcon.cat,
      totalPoints: 65,
    ),
    Child(
      familyId: 0,
      name: 'Robert',
      icon: ProfileIcon.giraffe,
      totalPoints: 30,
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
            for (final child in members) FamilyItem(member: child)
          ],
        ),
      ],
    );
  }
}
