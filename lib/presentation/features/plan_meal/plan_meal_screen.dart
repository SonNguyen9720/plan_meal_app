import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/plan_meal/bloc/plan_meal_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class PlanMealScreen extends StatelessWidget {
  const PlanMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PlanMealBloc, PlanMealState>(
        builder: (context, state) {
          return PlanMealAppScaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Text(
                      "Meal Plan",
                      style: TextStyle(fontSize: 42),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      decoration: const BoxDecoration(color: AppColors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                          ),
                          Text(
                            DateTime.now().toString(),
                            style: GoogleFonts.signika(
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(child: buildPlanMealBody()),
                    buildSubmitPlanMealButton(),
                  ],
                ),
              ),
              bottomMenuIndex: 1);
        },
      ),
    );
  }

  Widget buildPlanMealBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Calories Remaining",
                  style: GoogleFonts.signika(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildNutritionInfo("Goal", "2000", false),
                    Text(
                      "-",
                      style: GoogleFonts.signika(fontSize: 16),
                    ),
                    buildNutritionInfo("Food", "0", false),
                    Text(
                      "+",
                      style: GoogleFonts.signika(fontSize: 16),
                    ),
                    buildNutritionInfo("Exercise", "0", false),
                    Text(
                      "=",
                      style: GoogleFonts.signika(fontSize: 16),
                    ),
                    buildNutritionInfo("Remain", "2000", true),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: buildAddFoodContent("Breakfast", "0"),
          ),
          const SizedBox(
            height: 15,
          ),
          buildAddFoodContent("Lunch", "0"),
          const SizedBox(
            height: 15,
          ),
          buildAddFoodContent("Dinner", "0"),
          const SizedBox(
            height: 15,
          ),
          buildAddFoodContent("Snacks", "0"),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget buildNutritionInfo(String title, String value, bool isRemaining) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: GoogleFonts.signika(color: AppColors.gray),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(value,
            style: GoogleFonts.signika(
                fontSize: isRemaining ? 18 : 16,
                fontWeight: isRemaining ? FontWeight.bold : FontWeight.normal))
      ],
    );
  }

  Widget buildAddFoodContent(String title, String calories) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.signika(fontSize: 20),
              ),
              Text(
                calories,
                style: GoogleFonts.signika(
                  fontSize: 20,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          addFood(),
        ],
      ),
    );
  }

  Widget addFood() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: Text(
              "Add food",
              style: GoogleFonts.signika(
                fontSize: 16,
                color: AppColors.green,
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget buildSubmitPlanMealButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              "Add food",
              style: TextStyle(fontSize: 20),
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.green,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              primary: AppColors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
