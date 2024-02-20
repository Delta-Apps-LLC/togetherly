import 'package:flutter/material.dart';
import '../../themes.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.brandBlue,
      title: Padding(
        padding: const EdgeInsets.all(
            0.0), // May need to specify, but default seems to line up
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
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
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

    return BottomNavigationBar(
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
}
