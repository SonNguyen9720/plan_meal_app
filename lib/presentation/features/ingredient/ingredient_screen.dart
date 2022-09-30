import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/presentation/features/ingredient/bloc/ingredient_bloc.dart';
import 'package:plan_meal_app/presentation/features/ingredient/search.dart';

class IngredientScreen extends StatelessWidget {
  const IngredientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Ingredients"),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchIngredient());
                },
                icon: const Icon(Icons.search_sharp)),
          ],
        ),
        body: BlocBuilder<IngredientBloc, IngredientState>(
            builder: (context, ingredientState) {
          return Column(
            children: [],
          );
        }));
  }
}
