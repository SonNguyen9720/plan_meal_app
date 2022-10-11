import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal_weight/cubit/goal_weight_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class GoalWeight extends StatefulWidget {
  const GoalWeight({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<GoalWeight> createState() => _GoalWeightState();
}

class _GoalWeightState extends State<GoalWeight>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  late AnimationController animationController;
  late Animation animation;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation =
        Tween<double>(begin: 120.0, end: 30.0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        print("Text controller: Focus");
        animationController.forward();
      } else {
        print("Text controller: Unfocus");
        animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    animationController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocConsumer<GoalWeightCubit, GoalWeightState>(
            builder: (context, state) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const LinearProgress(value: 1 / 9),
                Text(
                  "What's your goal weight?",
                  style: GoogleFonts.signika(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Text(
                    "Your goal weight is important for creating a plan that will help you reach your goal",
                    style: GoogleFonts.signika(
                        fontSize: 20, color: AppColors.backgroundIndicator),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: animation.value,
                ),
                TextField(
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
                  focusNode: focusNode,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: NavigateButton(
                          text: "Next",
                          callbackFunc: () => navigatorFunc(widget.user)),
                    ),
                  ),
                )
              ]);
        }, listener: (context, state) {
          if (state is GoalWeightStored) {
            print("Navigate to other screen");
            Navigator.of(context).pushNamed(
                PlanMealRoutes.informationUserHeight,
                arguments: state.user);
          }
        }),
      ),
    ));
  }

  void navigatorFunc(User user) {
    BlocProvider.of<GoalWeightCubit>(context)
        .onNavigationButtonPressed(int.parse(textEditingController.text), user);
  }
}
