import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/exclusive_ingredient/cubit/exclusive_ingredient_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/exclusive_ingredient/search_ingredient.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class ExclusiveIngredientScreen extends StatelessWidget {
  final User user;

  const ExclusiveIngredientScreen({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            bottomSheet: BlocConsumer<ExclusiveIngredientCubit,
                ExclusiveIngredientState>(
              listener: (context, state) {
                if (state is ExclusiveIngredientSubmit) {
                  Navigator.pushNamed(context, PlanMealRoutes.signUp,
                      arguments: state.user);
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: NavigateButton(
                          text: "Next",
                          callbackFunc: () {
                            if (state is ExclusiveIngredientInitial) {
                              BlocProvider.of<ExclusiveIngredientCubit>(context)
                                  .onNavigateButtonPressed(
                                      user: user,
                                      ingredientList: state.ingredientList);
                            }
                          }),
                    )
                  ],
                );
              },
            ),
            body:
                BlocBuilder<ExclusiveIngredientCubit, ExclusiveIngredientState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const LinearProgress(value: 10),
                    SingleChildScrollView(
                      child: Column(children: [
                        const Text(
                          "What's your allergy ingredients",
                          style: TextStyle(fontSize: 32),
                          textAlign: TextAlign.center,
                        ),
                        const FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Text(
                            "It is okay to guess. You can change this later.",
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.backgroundIndicator),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        buildSearch(context, state),
                        ...buildListTile(state, context),
                      ]),
                    ),
                  ],
                );
              },
            )));
  }

  Widget buildSearch(BuildContext context, ExclusiveIngredientState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        readOnly: true,
        onTap: () async {
          if (kDebugMode) {
            print("Tap search");
          }
          var ingredientEntity = await showSearch(
              context: context, delegate: SearchExclusiveIngredient());
          if (state is ExclusiveIngredientInitial) {
            if (ingredientEntity != null) {
              BlocProvider.of<ExclusiveIngredientCubit>(context)
                  .onAddIngredientList(ingredientEntity, state.ingredientList);
            }
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: const Icon(
                Icons.search,
                color: AppColors.gray,
              ),
              width: 18,
            )),
      ),
    );
  }

  List<Widget> buildListTile(
      ExclusiveIngredientState state, BuildContext context) {
    if (state is ExclusiveIngredientInitial) {
      return List.generate(
          state.ingredientList.length,
          (index) => buildTile(
              state.ingredientList[index].ingredientName,
              () => BlocProvider.of<ExclusiveIngredientCubit>(context)
                  .onRemoveIngredientList(
                      state.ingredientList[index].ingredientId,
                      state.ingredientList)));
    }
    return [Container()];
  }

  Widget buildTile(String name, Function onDelete) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
              Expanded(
                  child: Text(
                name,
                style: const TextStyle(fontSize: 20),
              )),
              GestureDetector(
                onTap: () => onDelete,
                child: Column(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
