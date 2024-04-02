import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/family_item.dart';

class FamilyList extends StatefulWidget {
  const FamilyList({super.key, required this.title});
  final String title;

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
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
        Consumer<PersonProvider>(
          builder: (context, personProvider, child) => Column(
            children: personProvider.childList
                .map((child) => FamilyItem(
                      member: child,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
