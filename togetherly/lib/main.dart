import 'package:flutter/material.dart';
import 'package:togetherly/providers/app_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/utilities/env.dart';
import 'package:togetherly/views/screens/child_home.dart';
import 'package:togetherly/views/screens/parent_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ejsdquitvcfduhsrdwvx.supabase.co',
    anonKey: Env.supabaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: const MaterialApp(
        title: 'Togetherly',
        // home: ParentHomePage(),
        home: ChildHomePage(),
      ),
    );
  }
}
