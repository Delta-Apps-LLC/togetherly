import 'package:flutter/material.dart';

import '../themes.dart';

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
    // Add more items as needed
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
      // route to correct screen
    },
  );
}