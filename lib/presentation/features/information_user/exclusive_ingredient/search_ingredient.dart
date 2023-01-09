import 'package:flutter/material.dart';
import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/ingredient_repository_remote.dart';
import 'package:plan_meal_app/domain/entities/exclusive_ingredient_entity.dart';

class SearchExclusiveIngredient extends SearchDelegate {
  final IngredientRepositoryRemote ingredientRepository =
      IngredientRepositoryRemote();
  List<Ingredient> listIngredient = [];

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
    return buildSuggestionSuccess(listIngredient);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Ingredient>>(
        future: ingredientRepository.searchIngredient(query, 1),
        builder: (context, snapshot) {
          if (query == "") {
            return Container();
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
              listIngredient.addAll(snapshot.data ?? []);
              return buildSuggestionSuccess(snapshot.data);
          }
        });
  }

  Widget buildSuggestionSuccess(List<Ingredient>? ingredientList) {
    if (ingredientList == null || ingredientList.isEmpty) {
      return const Center(
          child: Text("Sorry, no ingredient is founded for you"));
    }
    return ListView.builder(
      itemCount: ingredientList.length,
      itemBuilder: (context, index) {
        return Card(
            child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ingredientList[index].name ?? "",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Calories: " + ingredientList[index].calories.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () async {
                  ExclusiveIngredientEntity exclusiveIngredientEntity =
                      ExclusiveIngredientEntity(
                          ingredientId: ingredientList[index].id.toString(),
                          ingredientName: ingredientList[index].name ?? "");
                  Navigator.of(context).pop(exclusiveIngredientEntity);
                },
                icon: const Icon(Icons.add))
          ],
        ));
      },
    );
  }
}
