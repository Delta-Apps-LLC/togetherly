import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/app_providers.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/scaffold_widgets.dart';
import 'package:togetherly/views/screens/approval.dart';
import 'package:togetherly/views/screens/child_home.dart';
import 'package:togetherly/views/screens/parent_home.dart';
import 'package:togetherly/views/screens/settings.dart';
import 'package:togetherly/views/screens/store.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({super.key, this.page});
  final Widget? page;

  Widget _getCurrentPage(int index, ScaffoldProvider provider) {
    switch (index) {
      case 0:
        if (provider.title == 'Chores') {
          return const ChildHomePage();
        } else {
          return const ParentHomePage();
        }
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

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'Togetherly',
        home: Consumer<ScaffoldProvider>(
          builder: (context, provider, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.brandBlue,
              // Leading will be conditional on Person model isChild/isParent
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => {provider.setAppBarTitle('Family')},
              ),
              title: CustomAppBarTitle(title: provider.title ?? ''),
            ),
            body: page ?? _getCurrentPage(provider.index ?? 0, provider),
            bottomNavigationBar: BottomNavBar(index: provider.index ?? 0),
          ),
        ),
      ),
    );
  }
}
