import 'package:flutter/material.dart';
import 'package:plan_meal_app/data/local/measurement_list.dart';
import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/ingredient_repository_remote.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';
import 'package:plan_meal_app/domain/entities/location_entity.dart';

class SearchIngredient extends SearchDelegate {
  final IngredientRepositoryRemote ingredientRepository =
      IngredientRepositoryRemote();
  final String type;
  List<Ingredient> listIngredient = [];
  int page = 1;

  SearchIngredient({required this.type});

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
    return SearchResult(ingredientList: listIngredient, type: type, query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Ingredient>>(
        future: ingredientRepository.searchIngredient(query, page),
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
          return GestureDetector(
            onTap: () {},
            child: Card(
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
                          "Calories: " +
                              ingredientList[index].calories.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        IngredientDetailEntity foodSearchEntity =
                            IngredientDetailEntity(
                          name: ingredientList[index].name ?? "",
                          quantity: 1,
                          imageUrl: ingredientList[index].imageUrl ?? "",
                          calories: ingredientList[index].calories ?? 0,
                          ingredientId:
                              ingredientList[index].id.toString(),
                          type: type,
                          measurementType: measurementList.first, location: const LocationEntity(id: "", location: ""),
                        );
                        Navigator.of(context).pop(foodSearchEntity);
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
            ),
          );
        });
  }
}

class SearchResult extends StatefulWidget {
  final List<Ingredient> ingredientList;
  final String type;
  final IngredientRepositoryRemote ingredientRepository =
      IngredientRepositoryRemote();
  final String query;

  SearchResult(
      {Key? key,
      required this.ingredientList,
      required this.type,
      required this.query})
      : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Ingredient> ingredientList = [];
  late int page;
  late bool isPerformingRequest;
  late bool isNoResult;

  @override
  void initState() {
    ingredientList.addAll(widget.ingredientList);
    page = 1;
    isPerformingRequest = false;
    isNoResult = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: ingredientList.length + 1,
              itemBuilder: (context, index) {
                if (index == ingredientList.length) {
                  return buildProcessIndicator();
                } else {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
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
                                  "Calories: " +
                                      ingredientList[index].calories.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                IngredientDetailEntity foodSearchEntity =
                                IngredientDetailEntity(
                                  name: ingredientList[index].name ?? "",
                                  quantity: 1,
                                  imageUrl: ingredientList[index].imageUrl ?? "",
                                  calories: ingredientList[index].calories ?? 0,
                                  ingredientId:
                                  ingredientList[index].id.toString(),
                                  type: widget.type,
                                  measurementType: measurementList.first,
                                  location: const LocationEntity(id: '', location: ''),
                                );
                                Navigator.of(context).pop(foodSearchEntity);
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                  );
                }
              }),
        ),
        isNoResult ? Container() :
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isPerformingRequest = true;
                  });
                  List<Ingredient> queryList = await widget.ingredientRepository
                      .searchIngredient(widget.query , page + 1);
                  if (queryList.isEmpty) {
                    setState(() {
                      isNoResult = true;
                    });
                  }
                  setState(() {
                    page = page + 1;
                    ingredientList.addAll(queryList);
                    isPerformingRequest = false;
                  });
                },
                child: const Text("Show more result", style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProcessIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
