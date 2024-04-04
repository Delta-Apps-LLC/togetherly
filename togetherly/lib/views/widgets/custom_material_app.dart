import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/app_providers.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/screens/home.dart';
import 'package:togetherly/views/widgets/scaffold_widgets.dart';
import 'package:togetherly/views/screens/approval.dart';
import 'package:togetherly/views/screens/settings.dart';
import 'package:togetherly/views/screens/reward.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({super.key, this.page});

  final Widget? page;

  final List<Widget> screens = const [
    HomePage(),
    ApprovalPage(),
    RewardPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'Togetherly',
        home: Consumer<ScaffoldProvider>(
          builder: (context, provider, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.brandBlue,
              leading: provider.childBeingViewed != null
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        provider.setScaffoldValues(
                            index: null,
                            title: 'Family', // TODO: replace with family name
                            type: HomePageType.parent,
                            childBeingViewed: null);
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
