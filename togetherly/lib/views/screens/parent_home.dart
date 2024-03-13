import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_list.dart';
import 'package:togetherly/views/widgets/family_list.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppWidgetStyles.appPadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FamilyList(title: 'Members'),
            SizedBox(height: 20.0),
            ChoreList(
              home: 'parent',
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
