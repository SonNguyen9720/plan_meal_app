import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/height/cubit/height_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen>
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
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomSheet: BlocBuilder<HeightCubit, HeightState>(
            builder: (context, state) {
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
            }),
          body: GestureDetector(
            onTap: () {
              print("Tap on screen");
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child:
                BlocConsumer<HeightCubit, HeightState>(builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const LinearProgress(value: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: size.height * 0.28),
                        child: Column(
                          children: const [
                            Text(
                              "What's your height? (cm)",
                              style: TextStyle(fontSize: 32),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        hintText: "180",
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
            }, listener: (context, state) {
              if (state is HeightStored) {
                Navigator.of(context).pushNamed(
                    PlanMealRoutes.informationUserActivityIntensity,
                    arguments: state.user);
              }
            }),
          ),
        ),
      ),
    );
  }

  void navigatorFunc(User user) {
    if (textEditingController.text.isNotEmpty) {
      BlocProvider.of<HeightCubit>(context).onNavigationButtonPressed(
          int.parse(textEditingController.text), user);
    }
  }
}
