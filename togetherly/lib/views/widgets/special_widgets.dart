import 'package:flutter/material.dart';
import '../../themes.dart';

class CustomAppBar {
  final String title;

  CustomAppBar({required this.title});

  PreferredSizeWidget get builtWidget => AppBar(
    backgroundColor: AppColors.brandBlue,
    title: Padding(
      padding: const EdgeInsets.all(0.0), // May need to specify, but default seems to line up
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo-name.png',
            width: 150.0,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: AppTextStyles.brandHeading,
          ),
        ],
      ),
    ),
  );
}

class BottomNavBar {
  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.store),
      label: 'Store',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  Widget get builtWidget => BottomNavigationBar(
    items: items,
    currentIndex: 0,
    backgroundColor: AppColors.brandBlue,
    selectedItemColor: AppColors.brandGold,
    unselectedItemColor: AppColors.brandBlack,
    selectedLabelStyle: AppTextStyles.brandAccentSub,
    unselectedLabelStyle: AppTextStyles.brandAccentSub,
    onTap: (index) {
      print(index);
    },
  );
}
