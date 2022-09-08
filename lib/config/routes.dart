//define routes of application

import 'package:flutter/material.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal/goal.dart';
import 'package:plan_meal_app/presentation/features/information_user/privacy/privacy_screen.dart';
import 'package:plan_meal_app/presentation/features/list_feature.dart';
import 'package:plan_meal_app/presentation/features/sign_in/sign_in_screen.dart';

class PlanMealRoutes {
  static const splashScreen = '/';
  static const onboard = 'onboard';
  static const listFeature = 'listFeature';
  static const informationUserName = 'informationUserName';
  static const informationUserPrivacy = 'informationUserPrivacy';
  static const informationUserGoal = 'informationUserGoal';
  static const signIn = 'signIn';
}

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PlanMealRoutes.listFeature:
        return MaterialPageRoute(builder: (_) => const ListFeatures());
      case PlanMealRoutes.informationUserPrivacy:
        var userName = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => PrivacyScreen(userName: userName));
      case PlanMealRoutes.informationUserGoal:
        return MaterialPageRoute(builder: (_) => GoalScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No route defined for ${settings.name}"),
                  ),
                ));
    }
  }
}
