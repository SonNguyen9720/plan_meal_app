import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/presentation/features/plan_meal/bloc/plan_meal_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/meal_tag.dart';
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
                    const Text(
                      "Meal Plan",
                      style:
                          TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      decoration: const BoxDecoration(color: AppColors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (state is PlanMealNoMeal) {
                                var newDateTime = state.dateTime
                                    .subtract(const Duration(days: 1));
                                BlocProvider.of<PlanMealBloc>(context).add(
                                    PlanMealLoadData(dateTime: newDateTime));
                              } else if (state is PlanMealHasMeal) {
                                var newDateTime = state.dateTime
                                    .subtract(const Duration(days: 1));
                                BlocProvider.of<PlanMealBloc>(context).add(
                                    PlanMealLoadData(dateTime: newDateTime));
                              }
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                          ),
                          Text(
                            getDateTime(state),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (state is PlanMealNoMeal) {
                                var newDateTime =
                                    state.dateTime.add(const Duration(days: 1));
                                BlocProvider.of<PlanMealBloc>(context).add(
                                    PlanMealLoadData(dateTime: newDateTime));
                              } else if (state is PlanMealHasMeal) {
                                var newDateTime =
                                    state.dateTime.add(const Duration(days: 1));
                                BlocProvider.of<PlanMealBloc>(context).add(
                                    PlanMealLoadData(dateTime: newDateTime));
                              }
                            },
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
                    Expanded(child: buildPlanMealBody(context, state)),
                    buildSubmitPlanMealButton(context, state),
                  ],
                ),
              ),
              bottomMenuIndex: 1);
        },
      ),
    );
  }

  Widget buildPlanMealBody(BuildContext context, PlanMealState state) {
    if (state is PlanMealLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PlanMealNoMeal) {
      return const Center(
        child: Text("No food on this day =("),
      );
    } else if (state is PlanMealHasMeal) {
      return ListView.builder(
          itemCount: state.foodMealEntity.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      BlocProvider.of<PlanMealBloc>(context).add(
                          PlanMealRemoveDishEvent(
                              dishId:
                                  state.foodMealEntity[index].foodId.toString(),
                              dateTime: state.dateTime,
                              meal: state.foodMealEntity[index].meal,
                              foodMealEntity: state.foodMealEntity));
                    },
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ],
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(children: [
                      if (state.foodMealEntity[index].image == "")
                        Container(
                          height: 80,
                          width: 80,
                          color: AppColors.gray,
                        )
                      else
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: Image.network(
                            state.foodMealEntity[index].image,
                            height: 80,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  MealTag(
                                      meal: state.foodMealEntity[index].meal),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  state.foodMealEntity[index].name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text("Calories: " +
                                  state.foodMealEntity[index].calories),
                              buildTrackedComponent(context, state, index),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            );
          });
    }
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
          children: const [
            Expanded(
                child: Text("Add food",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.green,
                    )))
          ],
        ),
      ),
    );
  }

  Widget buildSubmitPlanMealButton(BuildContext context, PlanMealState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(PlanMealRoutes.addFood, arguments: state.dateTime)
                  .whenComplete(() => BlocProvider.of<PlanMealBloc>(context)
                      .add(PlanMealLoadData(dateTime: state.dateTime)));
            },
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

  String getDateTime(PlanMealState state) {
    return DateTimeUtils.parseDateTime(state.dateTime);
  }

  Widget buildTrackedComponent(
      BuildContext context, PlanMealState state, int index) {
    if (state is PlanMealHasMeal) {
      return GestureDetector(
        onTap: () {
          BlocProvider.of<PlanMealBloc>(context).add(PlanMealTrackDishEvent(
              index: index,
              dishToMenu: state.foodMealEntity[index].foodToMenuId.toString(),
              dateTime: state.dateTime,
              meal: state.foodMealEntity[index].meal,
              foodMealEntity: state.foodMealEntity,
              tracked: !state.foodMealEntity[index].tracked));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              state.foodMealEntity[index].tracked
                  ? SvgPicture.asset(
                      "assets/food/check_circle.svg",
                      height: 24,
                      width: 24,
                    )
                  : SvgPicture.asset(
                      "assets/food/uncheck_circle.svg",
                      height: 24,
                      width: 24,
                    ),
              const SizedBox(
                width: 8,
              ),
              Text(
                state.foodMealEntity[index].tracked ? "Untrack" : "Track",
                style: const TextStyle(color: AppColors.gray, fontSize: 16),
              )
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
