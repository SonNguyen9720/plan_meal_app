//theme config in application

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSizes {}

class AppColors {
  static const green = Color(0xFF77D392);
  static const orange = Color.fromRGBO(242, 120, 75, 0.82);
  static const orangeLight = Color.fromRGBO(255, 192, 184, 1);
  static const orangeYellow = Color(0xFFF09F44);
  static const blue = Color(0xFF7DE5ED);
  static const red = Color(0xFFE75C51);
  static const white = Color(0xFFFFFFFF);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9D9B9B);
  static const darkGray = Color(0xFF979797);
  static const gray = Color.fromRGBO(124, 124, 124, 1);
  static const backgroundIndicator = Color(0xFFA9A9A9);
  static const backgroundInput = Color(0xFFF7F8F8);
  static const backgroundTabBar = Color(0xFFFFF8EE);
  static const indicatorTab = Color.fromRGBO(242, 120, 75, 0.82);
  static const nutritionTextColor = Color(0xFFFF8473);
  static const greenPastel = Color(0xFFEFF7EE);
  static const breakfastTag = Color(0xFFFEE9A6);
  static const lunchTag = Color(0xFFBFE1FC);
  static const dinnerTag = Color(0xFFE3D1EB);
  static const grey100 = Color(0xFFF5F5F5);
  static const grey300 = Color(0xFFE0E0E0);
}

class AppConst {}

class PlanMealAppTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: AppColors.green,
        backgroundColor: AppColors.background,
        dialogBackgroundColor: AppColors.backgroundLight,
        textTheme: GoogleFonts.nunitoTextTheme(),
        buttonTheme: theme.buttonTheme.copyWith(
          buttonColor: AppColors.green,
          minWidth: 50,
        ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white,
      ),
      colorScheme: theme.colorScheme.copyWith(
        primary: AppColors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: AppColors.black),
      )
    );
  }
}
