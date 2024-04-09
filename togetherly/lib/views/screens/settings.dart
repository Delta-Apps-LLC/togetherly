import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/auth_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/themes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void logout(AuthProvider authProvider) async {
      final scaffoldProvider =
          Provider.of<ScaffoldProvider>(context, listen: false);
      final userProvider =
          Provider.of<UserIdentityProvider>(context, listen: false);
      setState(() => _loading = true);
      await authProvider.logout();
      userProvider.setPersonId(null);
      setState(() => _loading = false);
      scaffoldProvider.setScaffoldValues(
          index: 0, title: 'Family', type: HomePageType.parent);
    }

    void changeProfile() {
      final userProvider =
          Provider.of<UserIdentityProvider>(context, listen: false);
      userProvider.setPersonId(null);
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
              ElevatedButton.icon(
                onPressed: () => changeProfile(),
                icon: const Icon(Icons.account_circle),
                label: const Text('Change Profile'),
              ),
              if (_loading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
