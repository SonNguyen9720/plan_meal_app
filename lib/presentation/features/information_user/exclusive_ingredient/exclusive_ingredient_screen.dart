import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/exclusive_ingredient/cubit/exclusive_ingredient_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class ExclusiveIngredientScreen extends StatelessWidget {
  final User user;

  const ExclusiveIngredientScreen({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            bottomSheet: BlocListener<ExclusiveIngredientCubit,
                ExclusiveIngredientState>(
              listener: (context, state) {
                if (state is ExclusiveIngredientSubmit) {
                  Navigator.pushNamed(context, PlanMealRoutes.signUp, arguments: state.user);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: NavigateButton(text: "Next", callbackFunc: () {}),
                  )
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: size.height * 0.2),
                  child: Column(
                    children: [
                      const LinearProgress(value: 6),
                      const Text(
                        "What's your allergy ingredients",
                        style: TextStyle(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      const FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Text(
                          "It is okay to guess. You can change this later",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.backgroundIndicator),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: TextField(
                          readOnly: true,
                          onTap: () async {},
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Search',
                              hintStyle: const TextStyle(
                                color: AppColors.gray,
                                fontSize: 18,
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(15),
                                child: const Icon(
                                  Icons.search,
                                  color: AppColors.gray,
                                ),
                                width: 18,
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Image.asset(
                                      "assets/ingredient/ingredients_default.png",
                                      height: 48,
                                      width: 48,
                                    )),
                                const Expanded(
                                    child: Text(
                                  "Olive oil",
                                  style: TextStyle(fontSize: 20),
                                )),
                                Column(
                                  children: const [
                                    Icon(
                                      Icons.delete,
                                      color: AppColors.red,
                                    ),
                                    Text(
                                      "Delete",
                                      style: TextStyle(color: AppColors.red),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
