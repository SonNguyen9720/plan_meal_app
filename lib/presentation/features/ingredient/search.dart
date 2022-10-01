import 'package:flutter/material.dart';
import 'package:plan_meal_app/presentation/widgets/independent/search_tile.dart';

class SearchIngredient extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.close))];
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
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const IngredientTile(
            ingredientName: 'Apple',
            isAdded: false,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const IngredientTile(
            ingredientName: 'Apple',
            isAdded: false,
          );
        });
  }
}
