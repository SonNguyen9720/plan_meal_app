import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/data/model/user.dart';

import 'bloc/goal_bloc.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GoalBloc, GoalState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Center(
            child: Text("Widget is ready"),
          );
        },
      ),
    );
  }
}
