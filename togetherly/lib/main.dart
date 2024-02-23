import 'package:flutter/material.dart';
import 'package:togetherly/providers/app_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/utilities/env.dart';
import 'views/screens/home.dart';

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
      child: MaterialApp(
        title: 'Togetherly',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'Home Page'),
      ),
    );
  }
}