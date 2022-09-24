import 'package:flutter/material.dart';
import 'package:plan_meal_app/data/model/user.dart';

class GoalWeight extends StatelessWidget {
  const GoalWeight({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Widget is ready"),
    );
  }
}
