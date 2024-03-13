import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/app_providers.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/screens/home.dart';
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

  @override
  Widget build(BuildContext context) {
    bool isParentViewingChild(ScaffoldProvider provider) {
      bool isParent = true; // TODO: replace with person provider isParent
      return provider.index == 0 &&
          isParent &&
          provider.homePageType == HomePageType.child;
    }

    return AppProviders(
      child: MaterialApp(
        title: 'Togetherly',
        home: Consumer<ScaffoldProvider>(
          builder: (context, provider, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.brandBlue,
              // Leading will be conditional on Person model isChild/isParent
              leading: isParentViewingChild(provider)
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        provider.setAppBarTitle('Family'); // TODO: replace with family name
                        provider.setHomePageType(HomePageType.parent);
                      },
                    )
                  : null,
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
