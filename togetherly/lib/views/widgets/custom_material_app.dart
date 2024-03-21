import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/app_providers.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/screens/home.dart';
import 'package:togetherly/views/screens/login.dart';
import 'package:togetherly/views/widgets/scaffold_widgets.dart';
import 'package:togetherly/views/screens/approval.dart';
import 'package:togetherly/views/screens/settings.dart';
import 'package:togetherly/views/screens/store.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({super.key, this.page});

  final Widget? page;

  final List<Widget> screens = const [
    HomePage(),
    ApprovalPage(),
    StorePage(),
    SettingsPage(),
  ];

  final bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'Togetherly',
        home: !loggedIn ? const LoginPage() : Consumer<ScaffoldProvider>(
          builder: (context, provider, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.brandBlue,
              // Leading will be conditional on Person model isChild/isParent
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back),
              //   onPressed: () => {provider.setAppBarTitle('Family')},
              // ),
              title: CustomAppBarTitle(title: provider.title ?? ''),
            ),
            body: page ?? screens.elementAt(provider.index ?? 0),
            bottomNavigationBar: BottomNavBar(index: provider.index ?? 0),
          ),
        ),
      ),
    );
  }
}
