import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_list.dart';
import 'package:togetherly/views/widgets/points.dart';

class ChildHomePage extends StatefulWidget {
  const ChildHomePage({super.key});

  @override
  State<ChildHomePage> createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppWidgetStyles.appPadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Points(),
            ChoreList(
              title: 'Today',
            ),
            SizedBox(height: 20.0),
            ChoreList(
              title: 'Upcoming',
            ),
            SizedBox(height: 20.0),
            ChoreList(
              title: 'Overdue',
            ),
          ],
        ),
      ),
    );
  }
}
