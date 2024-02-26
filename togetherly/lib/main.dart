import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/app_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/utilities/env.dart';
import 'package:togetherly/views/screens/approval.dart';
import 'package:togetherly/views/screens/child_home.dart';
import 'package:togetherly/views/screens/settings.dart';
import 'package:togetherly/views/screens/store.dart';
import 'package:togetherly/views/widgets/scaffold_widgets.dart';

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

  Widget _getHomePage(int index) {
    switch (index) {
      case 0:
        return const ChildHomePage();
      case 1:
        return const ApprovalPage();
      case 2:
        return const StorePage();
      case 3:
        return const SettingsPage();
      default:
        return const Placeholder();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'Togetherly',
        home: Consumer<ScaffoldProvider>(
          builder: (context, provider, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.brandBlue,
              title: CustomAppBarTitle(title: provider.title ?? ''),
            ),
            body: _getHomePage(provider.index ?? 0),
            bottomNavigationBar: BottomNavBar(index: provider.index ?? 0),
          ),
        ),
      ),
    );
  }
}
