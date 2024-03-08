import 'package:flutter/material.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_list.dart';
import 'package:togetherly/views/widgets/new_chore_dialog.dart';
import 'package:togetherly/views/widgets/points.dart';

class ChildHomePage extends StatefulWidget {
  const ChildHomePage({super.key});

  @override
  State<ChildHomePage> createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  final Child currentChild = const Child(
    id: 1,
    familyId: 1,
    name: 'Emma',
    icon: ProfileIcon.bear,
    totalPoints: 45,
  );

  Future<void> buildDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NewChoreDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppWidgetStyles.appPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.add, size: 30, color: Colors.transparent),
                  const Points(),
                  InkWell(
                    onTap: () => buildDialog(context),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: AppColors.brandBlack,
                    ),
                  ),
                ],
              ),
              const ChoreList(home: 'child',),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
    );
  }
}
