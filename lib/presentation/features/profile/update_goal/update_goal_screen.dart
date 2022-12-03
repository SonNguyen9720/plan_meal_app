import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/presentation/features/profile/update_goal/bloc/update_goal_bloc.dart';

class UpdateGoalScreen extends StatefulWidget {
  const UpdateGoalScreen({Key? key}) : super(key: key);

  @override
  State<UpdateGoalScreen> createState() => _UpdateGoalScreenState();
}

class _UpdateGoalScreenState extends State<UpdateGoalScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update goal"),
        ),
        body: BlocBuilder<UpdateGoalBloc, UpdateGoalState>(
          builder: (context, state) {
            if (state is UpdateGoalInitial) {
              return Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.isNotEmpty) {

                                  }
                                },
                                initialValue: PreferenceUtils.getString("weight"),
                                decoration: const InputDecoration(
                                  filled: true,
                                  labelText: "Current weight",
                                  labelStyle: TextStyle(color: AppColors.green),
                                  fillColor: AppColors.greenPastel,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.green),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.green),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.isNotEmpty) {

                                  }
                                },
                                initialValue: PreferenceUtils.getString("goalWeight"),
                                decoration: const InputDecoration(
                                  filled: true,
                                  labelText: "Goal weight",
                                  labelStyle: TextStyle(color: AppColors.green),
                                  fillColor: AppColors.greenPastel,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.green),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.green),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
        bottomSheet: BlocBuilder<UpdateGoalBloc, UpdateGoalState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: const BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
