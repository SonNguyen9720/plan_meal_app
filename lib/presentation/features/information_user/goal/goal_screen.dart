import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/widgets/independent/checkbox_tile.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

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
    "Stay motivated and consistent",
    "Feel better about my body"
  ];

  List<bool> listCheckBox = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LinearProgress(value: 1 / 9),
                Text(
                  "What is your goal?",
                  style: GoogleFonts.signika(fontSize: 32),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) => CheckboxTile(
                    iconsData: Icons.favorite,
                    title: listTitle[index],
                    onChanged: (value) {
                      _updateCheckBoxList(value!, index);
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: NavigateButton(
                      text: "Next", callbackFunc: _onNextButtonTap),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _updateCheckBoxList(bool value, int index) {
    if (value) {
      BlocProvider.of<GoalBloc>(context).add(AddGoalEvent(listTitle[index]));
    } else {
      BlocProvider.of<GoalBloc>(context).add(RemoveGoalEvent(listTitle[index]));
    }
  }

  void _onNextButtonTap() {
    BlocProvider.of<GoalBloc>(context).add(SubmitListGoalEvent(widget.user));
  }
}
