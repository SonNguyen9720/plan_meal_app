import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/string_utils.dart';
import 'package:plan_meal_app/presentation/features/information_user/birthday/cubit/birthday_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  TextEditingController birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<BirthdayCubit, BirthdayState>(
          listener: (context, state) {
            if (state is BirthdayStoraged) {
              print("Navigator to another screen");
              Navigator.of(context).pushNamed(
                  PlanMealRoutes.informationUserCurrentWeight,
                  arguments: state.user);
            }

            if (state is BirthdayError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.red,
                duration: const Duration(seconds: 3),
              ));
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LinearProgress(value: 1 / 9),
                  const Text(
                    "What is your birthday?",
                    style: TextStyle(fontSize: 32),
                  ),
                  const FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text(
                      "We need your age to accurately calculate your daily calorie goal",
                      style: TextStyle(
                          fontSize: 20, color: AppColors.backgroundIndicator),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Center(
                        child: TextFormField(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100)) ??
                                DateTime.now();
                            birthdayController.text = DateTimeUtils.parseDateTime(date);
                          },
                          controller: birthdayController,
                          decoration: const InputDecoration(
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        ),
        bottomSheet: BlocBuilder<BirthdayCubit, BirthdayState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: NavigateButton(
                      text: "Next",
                      callbackFunc: () => navigatorFunc(widget.user, context)),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void navigatorFunc(User user, BuildContext context) {
    BlocProvider.of<BirthdayCubit>(context)
        .onNavigateButtonPressed(birthdayController.text, user);
  }
}
