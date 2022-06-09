import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text(
              "Happy Meal",
              style: TextStyle(
                  fontSize: 30,
                  color: AppColors.green,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Center(
            child: SizedBox(
              height: 72,
              width: 290,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))))),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              ),
              GestureDetector(
                child: const Text(
                  "Log in",
                  style: TextStyle(
                      color: AppColors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
