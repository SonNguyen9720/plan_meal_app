import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 86,
          ),
          const Center(
            child: Text(
              "Happy Meal",
              style: TextStyle(
                color: AppColors.green,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 72,
              width: 290,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.green),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)))),
                onPressed: () {},
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "All ready have account? ",
                style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text("Log in",
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
