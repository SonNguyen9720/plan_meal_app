import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/gender/cubit/gender_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/gender_button.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<GenderCubit, GenderState>(
          listener: (context, state) {
            if (state is GenderSubmit) {
              print("Push to another screen");
              Navigator.of(context).pushNamed(
                  PlanMealRoutes.informationUserBirthday,
                  arguments: state.user);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LinearProgress(value: 3 / 9),
                  const Flexible(
                    flex: 3,
                    child: Text(
                      "What is your gender?",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: GenderButton(
                              iconData: Icons.female,
                              gender: "female",
                              isSelected: _checkFemaleIsSelected(state),
                            ),
                            onTap: () {
                              BlocProvider.of<GenderCubit>(context)
                                  .onGenderChoosing(true);
                            },
                          ),
                          InkWell(
                            child: GenderButton(
                              iconData: Icons.male,
                              gender: "male",
                              isSelected: _checkMaleIsSelected(state),
                            ),
                            onTap: () {
                              BlocProvider.of<GenderCubit>(context)
                                  .onGenderChoosing(false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomSheet: BlocBuilder<GenderCubit, GenderState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: NavigateButton(
                      text: "Next",
                      callbackFunc: () => navigatorFunc(user: widget.user)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool _checkFemaleIsSelected(GenderState state) {
    if (state is GenderFemaleChosen) {
      return true;
    }
    return false;
  }

  bool _checkMaleIsSelected(GenderState state) {
    if (state is GenderMaleChosen) {
      return true;
    }
    return false;
  }

  void navigatorFunc({required User user}) {
    BlocProvider.of<GenderCubit>(context).onNavigateButtonPressed(user: user);
  }
}
