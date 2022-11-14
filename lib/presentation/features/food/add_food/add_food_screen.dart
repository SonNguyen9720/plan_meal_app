import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/food/add_food/app_bar_cubit/title_cubit.dart';
import 'package:plan_meal_app/presentation/features/food/add_food/bloc/add_food_bloc.dart';
import 'package:plan_meal_app/presentation/features/food/add_food/search.dart';

class AddFoodScreen extends StatelessWidget {
  final DateTime dateTime;

  const AddFoodScreen({Key? key, required this.dateTime}) : super(key: key);
  static const List<String> mealList = ["Breakfast", "Lunch", "Dinner"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<TitleCubit, TitleState>(
      listener: (context, state) {
        if (state is TitleInitial) {
          BlocProvider.of<AddFoodBloc>(context)
              .add(AddFoodLoadFood(meal: state.title, date: DateTime.now()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<TitleCubit, TitleState>(
            builder: (context, state) {
              if (state is TitleInitial) {
                return DropdownButton(
                  value: state.title,
                  items: TitleState.mealTitle
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (TitleState.mealTitle.contains(value)) {
                      var index = TitleState.mealTitle.indexOf(value!);
                      BlocProvider.of<TitleCubit>(context).changeTitle(index);
                    }
                  },
                );
              }
              return const Text("Error bloc");
            },
          ),
        ),
        body: BlocBuilder<AddFoodBloc, AddFoodState>(
          builder: (context, state) {
            if (state is AddFoodLoading) {
              return const Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                height: 32,
                width: 32,
              ));
            } else if (state is AddFoodNoFood) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    child: TextField(
                      readOnly: true,
                      onTap: () async {
                        var foodSearch = await showSearch(
                            context: context,
                            delegate: FoodSearch(meal: state.meal));
                        BlocProvider.of<AddFoodBloc>(context).add(
                            AddFoodAddingFood(
                                foodSearchEntityList: const [],
                                foodAdd: foodSearch,
                                meal: state.meal,
                                date: state.date));
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: AppColors.gray,
                            fontSize: 18,
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(15),
                            child: const Icon(
                              Icons.search,
                              color: AppColors.gray,
                            ),
                            width: 18,
                          )),
                    ),
                  )
                ],
              );
            } else if (state is AddFoodHasFood) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    child: TextField(
                      readOnly: true,
                      onTap: () async {
                        var foodSearch = await showSearch(
                            context: context,
                            delegate: FoodSearch(meal: state.meal));
                        BlocProvider.of<AddFoodBloc>(context).add(
                            AddFoodAddingFood(
                                foodSearchEntityList: const [],
                                foodAdd: foodSearch,
                                meal: state.meal,
                                date: state.date));
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: AppColors.gray,
                            fontSize: 18,
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(15),
                            child: const Icon(
                              Icons.search,
                              color: AppColors.gray,
                            ),
                            width: 18,
                          )),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.foodSearchEntityList.length,
                      itemBuilder: (context, index) {
                        return Text(state.foodSearchEntityList[index].name);
                      }),
                  ),
                ],
              );
            }
            return const Text("No state to handle");
          },
        ),
      ),
    );
  }
}
