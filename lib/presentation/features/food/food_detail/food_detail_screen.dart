import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/food/food_detail/bloc/food_detail_bloc.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodDetailBloc, FoodDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FoodDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.green,
            ),
          );
        } else if (state is FoodDetailLoaded) {
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxScroll) => [
                SliverAppBar(
                  expandedHeight: 160,
                  flexibleSpace: FlexibleSpaceBar(
                    background: state.foodDetailEntity.imageUrl.isNotEmpty ? Image.network(
                      state.foodDetailEntity.imageUrl,
                      fit: BoxFit.cover,
                    ) : Container(color: AppColors.grey100,),
                  ),
                ),
              ],
              body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        state.foodDetailEntity.name,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: const BoxDecoration(
                          color: AppColors.orangeLight,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: AppColors.red,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text("${state.foodDetailEntity.calories} kcal",
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: const BoxDecoration(
                          color: AppColors.breakfastTag,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${state.foodDetailEntity.protein} g",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Proteins",
                                style: TextStyle(
                                  color: AppColors.gray,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Column(
                            children: [
                              Text(
                                "${state.foodDetailEntity.carb} g",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Carbs",
                                style: TextStyle(
                                  color: AppColors.gray,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Column(
                            children: [
                              Text(
                                "${state.foodDetailEntity.fat} g",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Fats",
                                style: TextStyle(
                                  color: AppColors.gray,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // bottomSheet: Container(
            //   width: MediaQuery
            //       .of(context)
            //       .size
            //       .width,
            //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //   decoration: const BoxDecoration(
            //     color: AppColors.green,
            //     borderRadius: BorderRadius.all(Radius.circular(8)),
            //   ),
            //   child: TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: const Text(
            //       "Add food",
            //       style: TextStyle(fontSize: 24, color: AppColors.white),
            //     ),
            //   ),
            // ),
          );
        }
        return const Center(child: Text("No state to handle"));
      },
    );
  }
}
