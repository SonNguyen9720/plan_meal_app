import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/domain/entities/ingredient_entity.dart';
import 'package:plan_meal_app/presentation/features/ingredient/bloc/ingredient_bloc.dart';
import 'package:plan_meal_app/presentation/features/ingredient/search.dart';
import 'package:plan_meal_app/presentation/widgets/independent/ingredient_tile.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({Key? key, required this.ingredientList})
      : super(key: key);

  final List<Ingredient> ingredientList;
  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  late List<TextEditingController> listTextEditingController;

  @override
  void initState() {
    super.initState();
    if (widget.ingredientList.isNotEmpty) {
      listTextEditingController =
          widget.ingredientList.map((e) => TextEditingController()).toList();
    } else {
      listTextEditingController = [];
    }
  }

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
            children: [
              Column(
                children: List.generate(widget.ingredientList.length, (index) {
                  return IngredientTile(
                    name: widget.ingredientList[index].name,
                    textEditingController: listTextEditingController[index],
                  );
                }),
              )
            ],
          );
        }));
  }
}
