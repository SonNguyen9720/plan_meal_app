import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Column(
        children: [
          Text(
            "Happy Meal",
            style: TextStyle(
              fontSize: 50
            ),
          ),
          Text("Healthy Meal - Happy life")
        ],
      ),
    );
  }
}