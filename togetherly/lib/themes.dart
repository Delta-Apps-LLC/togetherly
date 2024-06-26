import 'package:flutter/material.dart';

class AppColors {
  // Colors
  static const Color brandBlue = Color(0xFF779ecb);
  static const Color brandGreen = Color(0xFF90C3B1);
  static const Color brandGold = Color(0xFFFFD166);
  static const Color brandPurple = Color(0xFFD7C3E2);
  static const Color brandRose = Color(0xFFF9B5AC);
  static const Color brandGray = Color(0xFFA0A0A0);
  static const Color brandLightGray = Color(0xFFE7E7E7);
  static const Color brandBlack = Color(0xFF333333);
  static const Color brandWhite = Color(0xFFFBFBFB);
  static const Color errorRed = Color(0xFFFF676C);
}

class AppFonts {
  // Fonts
  static const String fontFamilyHeading = 'Quicksand';
  static const String fontFamilyBody = 'Lato';
  static const String fontFamilyAccent = 'Crimson Text';
}

class AppTextStyles {
  // Text Styles
  static const TextStyle brandHeading = TextStyle(
    color: AppColors.brandBlack,
    fontFamily: AppFonts.fontFamilyHeading,
    fontSize: 20,
  );
  static const TextStyle brandBody = TextStyle(
    color: AppColors.brandBlack,
    fontFamily: AppFonts.fontFamilyBody,
    fontSize: 16,
  );
  static const TextStyle brandBodySmall = TextStyle(
    color: AppColors.brandBlack,
    fontFamily: AppFonts.fontFamilyBody,
    fontSize: 14,
  );
  static const TextStyle brandBodyLarge = TextStyle(
    color: AppColors.brandBlack,
    fontFamily: AppFonts.fontFamilyBody,
    fontSize: 20,
  );
  static const TextStyle brandBodyStrike = TextStyle(
    color: AppColors.brandBlack,
    fontFamily: AppFonts.fontFamilyBody,
    fontSize: 16,
    decoration: TextDecoration.lineThrough,
  );
  static const TextStyle brandAccent = TextStyle(
    color: AppColors.brandBlack,
    fontFamily: AppFonts.fontFamilyAccent,
    fontSize: 16,
  );
  static const TextStyle brandAccentSub = TextStyle(
    color: AppColors.brandBlack,
    fontFamily: AppFonts.fontFamilyAccent,
    fontSize: 15,
  );
  static const TextStyle brandAccentLarge = TextStyle(
    color: AppColors.brandBlack,
    fontFamily: AppFonts.fontFamilyAccent,
    fontSize: 20,
  );
}

class AppWidgetStyles {
  static const EdgeInsets appPadding = EdgeInsets.only(
    top: 10,
    bottom: 1,
    left: 16,
    right: 16,
  );

  static const ButtonStyle submitButton = ButtonStyle(
    textStyle: MaterialStatePropertyAll(AppTextStyles.brandAccent),
    backgroundColor: MaterialStatePropertyAll(AppColors.brandGreen),
  );
}
