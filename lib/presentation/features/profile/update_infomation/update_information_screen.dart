import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/presentation/features/profile/update_infomation/bloc/update_information_bloc.dart';

const List<String> healthGoalList = [
  'eat_healthier',
  'boost_energy',
  'stay_motivated',
  'feed_better'
];

const List<String> activityIntensity = [
  'sedentary',
  'lightly_active',
  'moderately_active',
  'very_active',
  'extra_active'
];

class UpdateInformationScreen extends StatefulWidget {
  const UpdateInformationScreen({Key? key}) : super(key: key);

  @override
  State<UpdateInformationScreen> createState() =>
      _UpdateInformationScreenState();
}

class _UpdateInformationScreenState extends State<UpdateInformationScreen> {
  final formKey = GlobalKey<FormState>();
  String firstName = PreferenceUtils.getString("firstName") ?? "";
  String lastName = PreferenceUtils.getString("lastName") ?? "";
  String sex = PreferenceUtils.getString("sex") ?? "";
  String dob = PreferenceUtils.getString("dob") ?? "";
  String height = PreferenceUtils.getString("height") ?? "0";
  String dropdownValueHealthGoal = healthGoalList.first;
  String dropdownValueActivity = activityIntensity.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update information"),
      ),
      body: BlocConsumer<UpdateInformationBloc, UpdateInformationState>(
        listener: (context, state) async {
          if (state is UpdateInformationWaiting) {
            EasyLoading.show(
              status: "Loading ...",
              maskType: EasyLoadingMaskType.black,
            );
          } else if (state is UpdateInformationFinished) {
            await EasyLoading.dismiss();
            Navigator.of(context).pop();
          }
        },
        buildWhen: (previousState, state) {
          if (state is UpdateInformationWaiting ||
              state is UpdateInformationFinished) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 8, right: 8),
                            child: TextFormField(
                              onChanged: (value) {
                                firstName = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field must not be empty";
                                }
                                return null;
                              },
                              initialValue: PreferenceUtils.getString("firstName"),
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "First Name",
                                labelStyle: TextStyle(color: AppColors.green),
                                fillColor: AppColors.greenPastel,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.green),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.green),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              onChanged: (value) {
                                lastName = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field must not be empty";
                                }
                                return null;
                              },
                              initialValue: PreferenceUtils.getString("lastName"),
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "Last Name",
                                labelStyle: TextStyle(color: AppColors.green),
                                fillColor: AppColors.greenPastel,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.green),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.green),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            activeColor: AppColors.green,
                              value: 'male',
                              groupValue: sex,
                              title: const Text("Male"),
                              onChanged: (value) {
                                setState(() {
                                  sex = value!;
                                });
                              }),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            activeColor: AppColors.green,
                              value: 'female',
                              groupValue: sex,
                              title: const Text("Female"),
                              onChanged: (value) {
                                setState(() {
                                  sex = value!;
                                });
                              }),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100)) ??
                              DateTime.now();
                          dob = DateTimeUtils.parseDateTime(date);
                        },
                        onChanged: (value) {
                          dob = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field must not be empty";
                          }
                          return null;
                        },
                        initialValue: PreferenceUtils.getString("dob"),
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: "Date of birth",
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
                          height = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field must not be empty";
                          }
                          return null;
                        },
                        initialValue: PreferenceUtils.getString("height"),
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: "Height",
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
                        child: DropdownButtonFormField<String>(
                          value: dropdownValueHealthGoal,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            filled: true,
                            fillColor: AppColors.greenPastel,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            labelText: "Health Goal",
                            labelStyle: TextStyle(color: AppColors.green),
                          ),
                          isExpanded: true,
                          elevation: 16,
                          onChanged: (value) {
                            setState(() {
                              dropdownValueHealthGoal = value!;
                            });
                          },
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem<String>(
                              value: healthGoalList[0],
                              child: const Text("Eat and live healthier"),
                            ),
                            DropdownMenuItem<String>(
                              value: healthGoalList[1],
                              child: const Text("Boost my energy and mood"),
                            ),
                            DropdownMenuItem<String>(
                              value: healthGoalList[2],
                              child: const Text("Stay motivated and consistent"),
                            ),
                            DropdownMenuItem<String>(
                              value: healthGoalList[3],
                              child: const Text("Feel better about my body"),
                            ),
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: DropdownButtonFormField<String>(
                          value: dropdownValueActivity,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            filled: true,
                            fillColor: AppColors.greenPastel,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            labelText: "Health Goal",
                            labelStyle: TextStyle(color: AppColors.green),
                          ),
                          isExpanded: true,
                          elevation: 16,
                          onChanged: (value) {
                            setState(() {
                              dropdownValueActivity = value!;
                            });
                          },
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem<String>(
                              value: activityIntensity[0],
                              child: const Text("Sedentary"),
                            ),
                            DropdownMenuItem<String>(
                              value: activityIntensity[1],
                              child: const Text("Lightly active"),
                            ),
                            DropdownMenuItem<String>(
                              value: activityIntensity[2],
                              child: const Text("Moderately active"),
                            ),
                            DropdownMenuItem<String>(
                              value: activityIntensity[3],
                              child: const Text("Very active"),
                            ),
                            DropdownMenuItem<String>(
                              value: activityIntensity[4],
                              child: const Text("Extra active"),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomSheet: BlocBuilder<UpdateInformationBloc, UpdateInformationState>(
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
                      BlocProvider.of<UpdateInformationBloc>(context).add(
                          UpdateInformationSendEvent(
                              firstName: firstName,
                              lastName: lastName,
                              dob: dob,
                              sex: sex,
                              height: height,
                              healthGoal: dropdownValueHealthGoal,
                              activityIntensity: dropdownValueActivity));
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
        },
      ),
    );
  }
}
