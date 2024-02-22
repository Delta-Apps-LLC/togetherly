import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
=======
import 'views/screens/home.dart';
>>>>>>> 9301fb635dd750e45baeaef59f550a611f4309fe

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ejsdquitvcfduhsrdwvx.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVqc2RxdWl0dmNmZHVoc3Jkd3Z4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDY4NDM1NjgsImV4cCI6MjAyMjQxOTU2OH0._AkLYJzKGz8LH_sX6r1mvm0ydAl3l09qGQZ_N-6i4rQ',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Togetherly',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Home Page'),
    );
  }
}