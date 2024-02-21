import 'package:flutter/material.dart';
import 'package:togetherly/views/screens/child_home.dart';
import 'package:togetherly/views/screens/parent_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Togetherly',
      home: ParentHomePage(),
      // home: ChildHomePage(),
    );
  }
}
