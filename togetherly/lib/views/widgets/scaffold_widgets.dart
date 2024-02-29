import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.index});
  final int index;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _updateIndex(int index, ScaffoldProvider provider) {
    if (index == provider.index) return;
    provider.setNavIndex(index);
    switch (index) {
      case 0:
        provider.setAppBarTitle('Family');
        break;
      case 1:
        provider.setAppBarTitle('Approval');
        break;
      case 2:
        provider.setAppBarTitle('Store');
        break;
      case 3:
        provider.setAppBarTitle('Settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScaffoldProvider>(context, listen: false);

    final List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(
        backgroundColor: AppColors.brandBlue,
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        backgroundColor: AppColors.brandBlue,
        icon: Icon(Icons.hourglass_bottom_outlined),
        label: 'Approval',
      ),
      const BottomNavigationBarItem(
        backgroundColor: AppColors.brandBlue,
        icon: Icon(Icons.store),
        label: 'Store',
      ),
      const BottomNavigationBarItem(
        backgroundColor: AppColors.brandBlue,
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BottomNavigationBar(
          items: items,
          currentIndex: widget.index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.brandBlue,
          selectedItemColor: AppColors.brandGold,
          unselectedItemColor: AppColors.brandBlack,
          selectedLabelStyle: AppTextStyles.brandAccentSub,
          unselectedLabelStyle: AppTextStyles.brandAccentSub,
          onTap: (index) => _updateIndex(index, provider),
        ),
      ),
    );
  }
}
