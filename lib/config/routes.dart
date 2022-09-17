//define routes of application

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal/bloc/goal_bloc.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal/goal_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/privacy/privacy_screen.dart';
import 'package:plan_meal_app/presentation/features/list_feature.dart';

class PlanMealRoutes {
  static const splashScreen = '/';
  static const onboard = 'onboard';
  static const listFeature = 'listFeature';
  static const informationUserName = 'informationUserName';
  static const informationUserPrivacy = 'informationUserPrivacy';
  static const informationUserGoal = 'informationUserGoal';
  static const signIn = 'signIn';
  static const signUp = 'signUp';
}

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PlanMealRoutes.listFeature:
        return MaterialPageRoute(builder: (_) => const ListFeatures());
      case PlanMealRoutes.informationUserPrivacy:
        var user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => PrivacyScreen(user: user));
      case PlanMealRoutes.informationUserGoal:
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GoalBloc>(
                  create: (context) => GoalBloc(),
                  child: GoalScreen(user: user),
                ));
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
