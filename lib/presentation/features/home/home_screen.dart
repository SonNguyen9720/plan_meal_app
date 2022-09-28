import 'package:flutter/material.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PlanMealAppScaffold(
        body: Center(
          child: Text("Home screen"),
        ),
        bottomMenuIndex: 0);
  }
}
