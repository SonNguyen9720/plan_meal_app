import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/ingredient_detail/bloc/ingredient_detail_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class IngredientDetailScreen extends StatelessWidget {
  const IngredientDetailScreen({Key? key, required this.ingredientId})
      : super(key: key);
  final String ingredientId;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ingredient detail"),
        ),
        body: BlocBuilder<IngredientDetailBloc, IngredientDetailState>(
            builder: (context, state) {
          if (state is IngredientDetailLoading) {
            return const CircularProgressIndicator();
          }

          if (state is IngredientDetailSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 140,
                        width: 140,
                        child: Image.network(
                            "https://usapple.org/wp-content/uploads/2019/10/apple-gala.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Apple",
                          style: GoogleFonts.signika(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    color: AppColors.backgroundTabBar,
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Calories",
                                style: GoogleFonts.signika(
                                  fontSize: 16,
                                  color: AppColors.nutritionTextColor,
                                )),
                            Text("450g",
                                style: GoogleFonts.signika(
                                  fontSize: 20,
                                  color: AppColors.nutritionTextColor,
                                )),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Protein",
                                style: GoogleFonts.signika(
                                  fontSize: 16,
                                  color: AppColors.nutritionTextColor,
                                )),
                            Text("450g",
                                style: GoogleFonts.signika(
                                  fontSize: 20,
                                  color: AppColors.nutritionTextColor,
                                )),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Fat",
                                style: GoogleFonts.signika(
                                  fontSize: 16,
                                  color: AppColors.nutritionTextColor,
                                )),
                            Text("450g",
                                style: GoogleFonts.signika(
                                  fontSize: 20,
                                  color: AppColors.nutritionTextColor,
                                )),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Carbs",
                                style: GoogleFonts.signika(
                                  fontSize: 16,
                                  color: AppColors.nutritionTextColor,
                                )),
                            Text("450g",
                                style: GoogleFonts.signika(
                                  fontSize: 20,
                                  color: AppColors.nutritionTextColor,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.2),
                NavigateButton(
                  text: 'Add to cart',
                  callbackFunc: () {},
                ),
              ],
            );
          }

          if (state is IngredientDetailFailed) {
            return const Center(
              child: Text("Failed to load item"),
            );
          }
          return Text("No state handle");
        }));
  }
}
