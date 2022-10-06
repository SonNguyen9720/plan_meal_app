import 'package:flutter/material.dart';
import 'package:plan_meal_app/data/model/user.dart';

class ActivityIntensityScreen extends StatefulWidget {
  const ActivityIntensityScreen({Key? key, required this.user})
      : super(key: key);

  final User user;

  @override
  State<ActivityIntensityScreen> createState() =>
      _ActivityIntensityScreenState();
}

enum activityIntensity { notVeryActive, lightlyActive, active, veryActive }

class _ActivityIntensityScreenState extends State<ActivityIntensityScreen> {
  List<String> listTile = [];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Widget is ready"),
      ),
    );
  }
}
