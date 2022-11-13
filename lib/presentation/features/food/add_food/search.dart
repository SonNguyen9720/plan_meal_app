import 'package:flutter/material.dart';
import 'package:plan_meal_app/data/model/food.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/food_repository_remote.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';

class FoodSearch extends SearchDelegate {
  final FoodRepositoryRemote foodRepository = FoodRepositoryRemote();
  List<Food> resultFood = [];
  final String meal;

  FoodSearch({required this.meal});

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
      return const Center(child: Text("Sorry, no food found for you"));
    }
    return ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return Card(
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
                    onPressed: () {
                      var date = DateTimeUtils.parseDateTime(DateTime.now());
                      foodRepository.addMealFood(
                          foodList[index].id.toString(), date, meal);
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
          );
        });
  }
}
