import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/widgets/independent/checkbox_tile.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';
import 'package:plan_meal_app/presentation/widgets/independent/radio_tile.dart';

import 'bloc/goal_bloc.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  List<String> listTitle = [
    "Eat and live healthier",
    "Boost my energy and mood",
    "Feel better about my body",
    "Stay motivated and consistent",
  ];

  List<bool> listCheckBox = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<GoalBloc, GoalState>(
          listener: (context, state) {
            if (state is GoalSubmit) {
              Navigator.of(context).pushNamed(
                  PlanMealRoutes.informationUserGender,
                  arguments: state.user);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LinearProgress(value: 2),
                  const Flexible(
                    flex: 3,
                    child: Text(
                      "What is your goal?",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Center(
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => RadioTile(
                            iconsData: Icons.favorite,
                            title: listTitle[index],
                            initialValue: state is GoalInitial
                                ? state.render[index]
                                : false,
                            onChange: () {
                              if (state is GoalInitial) {
                                _updateRadioList(!state.render[index], index, context);
                              }
                            },
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: 4),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomSheet: BlocBuilder<GoalBloc, GoalState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: NavigateButton(
                        text: "Next", callbackFunc: () {
                      if (state is GoalInitial) {
                        var healthGoal =
                        state.healthGoalMap.keys.firstWhere(
                                (index) =>
                            state.healthGoalMap[index] == true,
                            orElse: () => HealthGoal.empty);
                        BlocProvider.of<GoalBloc>(context)
                            .add(SubmitListGoalEvent(widget.user, healthGoal));
                      }
                    }),
                  )
                ],
              );
            },
        ),
      ),
    );
  }

  void _updateRadioList(bool value, int index, BuildContext context) {
    print("Call event");
    if (value) {
      BlocProvider.of<GoalBloc>(context)
          .add(UpdateGoalEvent(index));
    }
  }
}
