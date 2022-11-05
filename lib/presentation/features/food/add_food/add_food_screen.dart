import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/presentation/features/food/add_food/app_bar_cubit/title_cubit.dart';
import 'package:plan_meal_app/presentation/features/food/add_food/bloc/add_food_bloc.dart';
import 'package:plan_meal_app/presentation/features/splashscreen/splash_screen.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({Key? key}) : super(key: key);
  static const List<String> mealList = ["Breakfast", "Lunch", "Dinner"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TitleCubit, TitleState>(
          builder: (context, state) {
            if (state is TitleInitial) {
              return DropdownButton(
                value: state.title,
                items: TitleState.mealTitle
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
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
          return const Text("No state to handle");
        },
      ),
    );
  }
}
