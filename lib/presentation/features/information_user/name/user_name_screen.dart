import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

import 'cubit/user_name_cubit.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<UserNameCubit, UserNameState>(
          listener: (context, state) {
            if (state is UserNameStoraged) {
              Navigator.pushNamed(
                  context, PlanMealRoutes.informationUserPrivacy,
                  arguments: state.user);
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LinearProgress(value: 1),
                  const Text(
                    "What is your name?",
                    style: TextStyle(fontSize: 32),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Icon(
                      Icons.account_circle_sharp,
                      size: 90,
                      color: AppColors.green,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          hintText: "Your first name",
                          hintStyle: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          hintText: "Your last name",
                          hintStyle: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomSheet: BlocBuilder<UserNameCubit, UserNameState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: NavigateButton(
                      text: "Next", callbackFunc: () {
                    if (firstNameController.text.isEmpty && lastNameController.text.isEmpty) {
                      return;
                    }
                    BlocProvider.of<UserNameCubit>(context)
                        .onNavigateButtonPressed(firstNameController.text, lastNameController.text);
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
