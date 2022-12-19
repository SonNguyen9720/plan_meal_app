import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
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

class _CurrentWeightState extends State<CurrentWeight>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
          bottomSheet: BlocBuilder<CurrentWeightCubit, CurrentWeightState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: NavigateButton(
                        text: "Next",
                        callbackFunc: () => navigatorFunc(widget.user)),
                  )
                ],
              );
            },
          ),
          body: GestureDetector(
            onTap: () {
              print("Tap on screen");
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: BlocConsumer<CurrentWeightCubit, CurrentWeightState>(
              listener: (context, state) {
                if (state is CurrentWeightStoraged) {
                  Navigator.of(context).pushNamed(
                      PlanMealRoutes.informationUserGoalWeight,
                      arguments: state.user);
                }
              },
              builder: (context, state) {
                var size = MediaQuery.of(context).size;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const LinearProgress(value: 6),
                    Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.2),
                      child: Column(
                        children: const [
                          Text(
                            "What's your current weight? (Kg)",
                            style: TextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Text(
                              "It is okay to guess. You can always adjust your starting weight later",
                              style: TextStyle(
                                  fontSize: 20, color: AppColors.backgroundIndicator),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        focusNode: focusNode,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void navigatorFunc(User user) {
    BlocProvider.of<CurrentWeightCubit>(context)
        .onNavigateButtonPressed(int.parse(textEditingController.text), user);
  }
}
