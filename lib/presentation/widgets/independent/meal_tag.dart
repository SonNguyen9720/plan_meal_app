import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class MealTag extends StatelessWidget {
  final String meal;
  final Map<String, Colors> colorMap = {};

  MealTag({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          color: getColor(meal),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Text(
        meal,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Color getColor(String meal) {
    if (meal == "Breakfast") {
      return AppColors.breakfastTag;
    } else if (meal == "Lunch") {
      return AppColors.lunchTag;
    } else {
      return AppColors.dinnerTag;
    }
  }

  String getNameTag(String meal) {
    if (meal == "BREAKFAST") {
      return "Breakfast";
    } else if (meal == "LUNCH") {
      return "Lunch";
    } else {
      return "Dinner";
    }
  }
}
