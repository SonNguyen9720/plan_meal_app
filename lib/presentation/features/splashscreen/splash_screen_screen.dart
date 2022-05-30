import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  "Happy Meal",
                  style: TextStyle(
                    fontSize: 50,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Text(
            "Healthy Meal - Happy life",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
