import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 80,
        child: PhysicalModel(
          color: AppColors.brandWhite,
          borderRadius: BorderRadius.circular(40),
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.bolt,
                size: 32,
                color: AppColors.brandGold,
              ),
              Text(
                '65',
                style: AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
