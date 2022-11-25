import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class FoodTypeTag extends StatelessWidget {
  final String type;

  const FoodTypeTag({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: const BoxDecoration(
          color: AppColors.greenPastel,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Text(
        type,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
