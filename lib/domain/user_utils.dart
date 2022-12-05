import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';

class UserUtils {
  static Future<void> logOut(BuildContext context) async {
    await PreferenceUtils.clear();
    Navigator.of(context).pushNamed(PlanMealRoutes.onboard);
  }
}