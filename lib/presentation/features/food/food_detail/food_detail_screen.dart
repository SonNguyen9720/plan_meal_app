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
                    background: state.foodDetailEntity.imageUrl.isNotEmpty
                        ? Image.network(
                            state.foodDetailEntity.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: AppColors.grey100,
                          ),
                  ),
                ),
              ],
              body: SingleChildScrollView(
                child: Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<FoodDetailBloc>(context).add(
                                  FoodDetailDislikeEvent(
                                      dishId: (state).foodDetailEntity.foodId,
                                      foodDetailEntity:
                                          state.foodDetailEntity));
                            },
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: const BoxDecoration(
                                  // border: Border.all(color: AppColors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.thumb_down_outlined,
                                    color: AppColors.red,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Disliked",
                                      style: TextStyle(
                                        color: AppColors.red,
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<FoodDetailBloc>(context).add(
                                  FoodDetailLikeEvent(
                                      dishId: (state).foodDetailEntity.foodId,
                                      foodDetailEntity:
                                      state.foodDetailEntity));
                            },
                            child: Container(
                                width: 100,
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: const BoxDecoration(
                                    // border: Border.all(color: AppColors.green),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.thumb_up_outlined,
                                      color: AppColors.green,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Liked",
                                      style: TextStyle(
                                          fontSize: 16, color: AppColors.green),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: const BoxDecoration(
                                color: AppColors.orangeLight,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: const BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${state.foodDetailEntity.cookingTime} min",
                                    style: const TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
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
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              state.foodDetailEntity.description,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Recipe",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              state.foodDetailEntity.recipe,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
        } else if (state is FoodDetailedSelectedState) {
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxScroll) => [
                SliverAppBar(
                  expandedHeight: 160,
                  flexibleSpace: FlexibleSpaceBar(
                    background: state.foodDetailEntity.imageUrl.isNotEmpty
                        ? Image.network(
                            state.foodDetailEntity.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: AppColors.grey100,
                          ),
                  ),
                ),
              ],
              body: SingleChildScrollView(
                child: Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<FoodDetailBloc>(context).add(
                                  FoodDetailDeselectEvent(
                                      isLiked: false,
                                      dishId: (state).foodDetailEntity.foodId,
                                      foodDetailEntity:
                                          state.foodDetailEntity));
                            },
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: const BoxDecoration(
                                  // border: Border.all(color: AppColors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  state.isLiked
                                      ? const Icon(
                                          Icons.thumb_down_outlined,
                                          color: AppColors.red,
                                        )
                                      : const Icon(
                                          Icons.thumb_down,
                                          color: AppColors.red,
                                        ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Disliked",
                                      style: TextStyle(
                                        color: AppColors.red,
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<FoodDetailBloc>(context).add(
                                  FoodDetailDeselectEvent(
                                      isLiked: true,
                                      dishId: (state).foodDetailEntity.foodId,
                                      foodDetailEntity:
                                          state.foodDetailEntity));
                            },
                            child: Container(
                                width: 100,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: const BoxDecoration(
                                    // border: Border.all(color: AppColors.green),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    state.isLiked
                                        ? const Icon(
                                            Icons.thumb_up,
                                            color: AppColors.green,
                                          )
                                        : const Icon(
                                            Icons.thumb_up_outlined,
                                            color: AppColors.green,
                                          ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Liked",
                                      style: TextStyle(
                                          fontSize: 16, color: AppColors.green),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: const BoxDecoration(
                                color: AppColors.orangeLight,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: const BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${state.foodDetailEntity.cookingTime} min",
                                    style: const TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
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
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              state.foodDetailEntity.description,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Recipe",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              state.foodDetailEntity.recipe,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
