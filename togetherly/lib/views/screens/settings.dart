import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/auth_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    void logout(AuthProvider authProvider) async {
      final scaffoldProvider =
          Provider.of<ScaffoldProvider>(context, listen: false);
      await authProvider.logout();
      scaffoldProvider.setScaffoldValues(
          index: 0, title: 'Family', type: HomePageType.parent);
    }

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
                onPressed: () => logout(authProvider),
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
