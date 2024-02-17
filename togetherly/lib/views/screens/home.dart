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
        padding: EdgeInsets.only(top: 2, bottom: 2, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
      ),
      bottomNavigationBar: bottomNavBar.builtWidget,
    );
  }
}
