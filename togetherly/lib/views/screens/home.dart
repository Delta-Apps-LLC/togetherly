import 'package:flutter/material.dart';
import 'package:togetherly/views/screens/child_home.dart';
import 'package:togetherly/views/screens/parent_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool isParent = false;

  @override
  Widget build(BuildContext context) {
    return isParent ? const ParentHomePage() : const ChildHomePage();
  }
}
