import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/birthday/cubit/birthday_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';
import 'package:intl/intl.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LinearProgress(value: 1 / 9),
                  Text(
                    "What is your birthday?",
                    style: GoogleFonts.signika(fontSize: 32),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text(
                      "We need your age to accurately calculate your daily calorie goal",
                      style: GoogleFonts.signika(
                          fontSize: 20, color: AppColors.backgroundIndicator),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Center(
                        child: TextField(
                          controller: birthdayController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: "30/02/1998",
                            hintStyle: GoogleFonts.signika(
                              fontSize: 40,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.signika(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: NavigateButton(
                        text: "Next",
                        callbackFunc: () => navigatorFunc(widget.user)),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void navigatorFunc(User user) {
    BlocProvider.of<BirthdayCubit>(context)
        .onNavigateButtonPressed(birthdayController.text, user);
  }
}
