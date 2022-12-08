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
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
        bottomSheet: BlocBuilder<GoalWeightCubit, GoalWeightState>(
          builder: (context, builder) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: NavigateButton(
                      text: "Next",
                      callbackFunc: () => navigatorFunc(widget.user)),
                ),
              ],
            );
          },
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: BlocConsumer<GoalWeightCubit, GoalWeightState>(
              builder: (context, state) {
                var size = MediaQuery.of(context).size;
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const LinearProgress(value: 1 / 9),
                  const Text(
                    "What's your goal weight? (kg)",
                    style: TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text(
                      "Your goal weight is important for creating a plan that will help you reach your goal",
                      style: TextStyle(
                          fontSize: 20, color: AppColors.backgroundIndicator),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: size.height * 0.15,),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        hintText: "79",
                        hintStyle: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
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
      )),
    );
  }

  void navigatorFunc(User user) {
    BlocProvider.of<GoalWeightCubit>(context)
        .onNavigationButtonPressed(int.parse(textEditingController.text), user);
  }
}
