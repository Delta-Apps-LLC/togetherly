import 'package:flutter/material.dart';
import 'package:togetherly/views/widgets/special_widgets.dart';
import 'package:togetherly/views/widgets/chore_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bottomNavBar = BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chores').builtWidget,
      body: const Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ChoreList(
              title: 'Today',
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar.builtWidget,
    );
  }
}
