import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/presentation/features/profile/update_goal/bloc/update_goal_bloc.dart';

class UpdateGoalScreen extends StatefulWidget {
  const UpdateGoalScreen({Key? key}) : super(key: key);

  @override
  State<UpdateGoalScreen> createState() => _UpdateGoalScreenState();
}

class _UpdateGoalScreenState extends State<UpdateGoalScreen> {
  final formKey = GlobalKey<FormState>();
  String currentWeight = PreferenceUtils.getString("weight") ?? "";
  String goalWeight = PreferenceUtils.getString("goalWeight") ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update goal"),
        ),
        body: BlocConsumer<UpdateGoalBloc, UpdateGoalState>(
          listener: (context, state) async {
            if (state is UpdateGoalWaiting) {
              EasyLoading.show(
                status: "Loading ...",
                maskType: EasyLoadingMaskType.black,
              );
            } else if (state is UpdateGoalFinished) {
              await EasyLoading.dismiss();
              Navigator.of(context).pop();
            }
          },
          buildWhen: (previousState, state) {
            if (state is UpdateGoalWaiting || state is UpdateGoalFinished) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is UpdateGoalInitial) {
              return Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                onChanged: (value) {
                                  currentWeight = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field must not be empty";
                                  }
                                  return null;
                                },
                                initialValue:
                                    PreferenceUtils.getString("weight"),
                                decoration: const InputDecoration(
                                  filled: true,
                                  labelText: "Current weight",
                                  labelStyle: TextStyle(color: AppColors.green),
                                  fillColor: AppColors.greenPastel,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.green),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.green),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                onChanged: (value) {
                                  goalWeight = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field must not be empty";
                                  }
                                  return null;
                                },
                                initialValue:
                                    PreferenceUtils.getString("goalWeight"),
                                decoration: const InputDecoration(
                                  filled: true,
                                  labelText: "Goal weight",
                                  labelStyle: TextStyle(color: AppColors.green),
                                  fillColor: AppColors.greenPastel,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.green),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.green),
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
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<UpdateGoalBloc>(context).add(
                          UpdateGoalSendEvent(
                              currentWeight: currentWeight,
                              desiredWeight: goalWeight));
                    }
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
        }),
      );
  }
}
