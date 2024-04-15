import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/family_child_item.dart';
import 'package:togetherly/views/widgets/family_parent_item.dart';
import 'package:togetherly/views/widgets/edit_person_dialog.dart';

class FamilyList extends StatefulWidget {
  const FamilyList({super.key, required this.title});
  final String title;

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  @override
  Widget build(BuildContext context) {
    Future<void> buildPersonDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const EditPersonDialog();
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // Aligns to center
      crossAxisAlignment: CrossAxisAlignment.stretch, // Aligns to left
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
            ),
            InkWell(
              onTap: () => buildPersonDialog(context),
              child: const Icon(
                Icons.person_add,
                size: 30,
                color: AppColors.brandBlack,
              ),
            ),
          ],
        ),
        Consumer<PersonProvider>(
          builder: (context, personProvider, child) => Column(
            children: [
              ...personProvider.parents
                  .map((parent) => FamilyParentItem(
                        parent: parent,
                      ))
                  .toList(),
              ...personProvider.children
                  .map((child) => FamilyChildItem(
                        child: child,
                      ))
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }
}
