//theme config in application

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSizes {}

class AppColors {
  static const green = Color.fromRGBO(108, 209, 92, 1);
  static const orange = Color.fromRGBO(242, 120, 75, 0.82);
  static const red = Color(0xFFDB3022);
  static const white = Color(0xFFFFFFFF);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);  
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
}

class AppConst {}

class PlanMealAppTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: AppColors.green,
      backgroundColor: AppColors.background,
      dialogBackgroundColor: AppColors.backgroundLight,
      textTheme: GoogleFonts.signikaTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }
}