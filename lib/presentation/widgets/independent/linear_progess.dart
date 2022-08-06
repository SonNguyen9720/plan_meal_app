import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class LinearProgress extends StatelessWidget {
  const LinearProgress({Key? key, required this.value}) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      child: const FractionallySizedBox(
        widthFactor: 0.8,
        child: LinearProgressIndicator(
          value: 1 / 9,
          color: AppColors.green,
          backgroundColor: AppColors.backgroundIndicator,
        ),
      ),
    );
  }
}
