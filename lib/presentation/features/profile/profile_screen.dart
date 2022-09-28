import 'package:flutter/material.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: PlanMealAppScaffold(
        bottomMenuIndex: 4,
        body: Center(
          child: Text("Profile"),
        ),
      ),
    );
  }
}
