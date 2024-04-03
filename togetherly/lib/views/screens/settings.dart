import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/auth_provider.dart';
import 'package:togetherly/themes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Padding(
        padding: AppWidgetStyles.appPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text('Hello there! This is the Settings page.'),
              ),
              ElevatedButton.icon(
                onPressed: () => authProvider.logout(),
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
