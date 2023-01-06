import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/data/model/food.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/food_repository_remote.dart';
import 'package:plan_meal_app/domain/entities/food_search_entity.dart';
import 'package:plan_meal_app/presentation/features/food/food_detail/bloc/food_detail_bloc.dart';
import 'package:plan_meal_app/presentation/features/food/food_detail/food_detail_screen.dart';

import '../../../../data/repositories/abstract/food_repository.dart';

class FoodSearch extends SearchDelegate {
  final FoodRepositoryRemote foodRepository = FoodRepositoryRemote();
  List<Food> resultFood = [];
  final String meal;
  final String type;
  final DateTime dateTime;
  final List<FoodSearchEntity> foodSearchEntityList;

  FoodSearch(
      {required this.meal,
      required this.type,
      required this.dateTime,
      required this.foodSearchEntityList});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestionSuccess(resultFood);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Food>>(
        future: foodRepository.searchFoodList(query),
        builder: (context, snapshot) {
          if (query == "") {
            return const SizedBox.shrink();
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("There is something error. Please try again");
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (!snapshot.hasData || snapshot.hasError) {
                return const Center(
                    child: Text("Sorry, no food found for you"));
              }
              resultFood.addAll(snapshot.data ?? []);
              return buildSuggestionSuccess(snapshot.data);
          }
        });
  }

  Widget buildSuggestionSuccess(List<Food>? foodList) {
    if (foodList == null || foodList.isEmpty) {
      return const Center(child: Text("Sorry, no food is founded for you"));
    }
    return ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) => BlocProvider<FoodDetailBloc>(
                        create: (context) => FoodDetailBloc(
                          foodRepository:
                              RepositoryProvider.of<FoodRepository>(context),
                          userRepository:
                              RepositoryProvider.of<UserRepository>(context),
                        )..add(FoodDetailLoadEvent(
                            foodId: foodList[index].id.toString())),
                        child: const FoodDetailScreen(),
                      ));
            },
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodList[index].name ?? "",
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Calories: " + foodList[index].calories.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        FoodSearchEntity foodSearchEntity = FoodSearchEntity(
                          id: foodList[index].id.toString(),
                          name: foodList[index].name ?? "",
                          calories: foodList[index].calories ?? 0,
                          imageUrl: foodList[index].imageUrl ?? "",
                          quantity: 1,
                          fat: foodList[index].fat ?? 0,
                          carb: foodList[index].carbohydrates ?? 0,
                          protein: foodList[index].protein ?? 0,
                          type: type,
                          dishType: 'cooking',
                        );
                        Map<String, dynamic> params = {
                          'foodSearchEntity': foodSearchEntity,
                          'type': type,
                          'meal': meal,
                          'inputList': foodSearchEntityList,
                          'dateTime': dateTime
                        };
                        Navigator.of(context).pushNamed(
                            PlanMealRoutes.addFoodDetail,
                            arguments: params);
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
            ),
          );
        });
  }
}
