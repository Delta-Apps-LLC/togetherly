import 'package:flutter/material.dart';
import 'package:togetherly/views/screens/child_home.dart';
import 'package:togetherly/views/screens/parent_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final bool isParent = true;

  @override
  Widget build(BuildContext context) {
    return isParent ? const ParentHomePage() : const ChildHomePage();
  }
}
