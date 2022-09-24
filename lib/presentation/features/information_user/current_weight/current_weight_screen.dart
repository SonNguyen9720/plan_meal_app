import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/current_weight/cubit/current_weight_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class CurrentWeight extends StatefulWidget {
  const CurrentWeight({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<CurrentWeight> createState() => _CurrentWeightState();
}

class _CurrentWeightState extends State<CurrentWeight> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<CurrentWeightCubit, CurrentWeightState>(
          listener: (context, state) {
            if (state is CurrentWeightStoraged) {}
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LinearProgress(value: 1 / 9),
                  Text(
                    "What is your current weight?",
                    style: GoogleFonts.signika(fontSize: 32),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text(
                      "It is okey to guess. You can always adjust your starting weight later",
                      style: GoogleFonts.signika(
                          fontSize: 20, color: AppColors.backgroundIndicator),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: "79",
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
    BlocProvider.of<CurrentWeightCubit>(context)
        .onNavigateButtonPressed(int.parse(textEditingController.text), user);
  }
}
