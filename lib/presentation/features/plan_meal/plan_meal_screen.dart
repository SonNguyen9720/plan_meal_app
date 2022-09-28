import 'package:flutter/material.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class PlanMealScreen extends StatelessWidget {
  const PlanMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: PlanMealAppScaffold(
          body: Center(
            child: Text("Plan meal"),
          ),
          bottomMenuIndex: 1),
    );
  }
}
