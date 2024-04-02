import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/views/screens/child_home.dart';
import 'package:togetherly/views/screens/parent_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScaffoldProvider>(
        builder: (context, provider, child) => switch (provider.homePageType) {
              HomePageType.parent => const ParentHomePage(),
              HomePageType.child => const ChildHomePage()
            });
  }
}
