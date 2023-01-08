import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/profile/food_exclusive/bloc/food_exclusive_bloc.dart';

class FoodExclusiveScreen extends StatelessWidget {
  const FoodExclusiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food exclusion",
        ),
      ),
      body: BlocBuilder<FoodExclusiveBloc, FoodExclusiveState>(
        builder: (context, state) {
          if (state is FoodExclusiveLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: TextField(
                  readOnly: true,
                  onTap: () async {
                    // var foodSearch = await showSearch(
                    //     context: context,
                    //     delegate: );
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
              BlocBuilder<FoodExclusiveBloc, FoodExclusiveState>(
                  builder: (context, state) {
                if (state is FoodExclusiveLoadedState) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: state.foodExclusiveEntityList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                    state.foodExclusiveEntityList[index].name),
                                trailing: GestureDetector(
                                  onTap: () {

                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                  ),
                                ),
                              ),
                            );
                          }));
                }
                return Container();
              }),
            ],
          );
        },
      ),
    );
  }
}
