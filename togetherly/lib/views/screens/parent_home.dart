import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/app_bar.dart';
import 'package:togetherly/views/widgets/family_list.dart';
import 'package:togetherly/views/widgets/nav_bar.dart';

class ParentHomePage extends StatefulWidget {
  const ParentHomePage({super.key});

  @override
  State<ParentHomePage> createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Family').build(context),
      body: const Padding(
        padding: AppWidgetStyles.appPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FamilyList(title: 'Members'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
