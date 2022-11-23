import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/food/add_food/app_bar_cubit/title_cubit.dart';
import 'package:plan_meal_app/presentation/features/food/add_food/bloc/add_food_bloc.dart';
import 'package:plan_meal_app/presentation/features/food/add_food/search.dart';

class AddFoodScreen extends StatelessWidget {
  final DateTime dateTime;

  const AddFoodScreen({Key? key, required this.dateTime}) : super(key: key);
  static const List<String> mealList = ["breakfast", "lunch", "dinner"];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TitleCubit, TitleState>(
          listener: (context, state) {
            if (state is TitleInitial) {
              BlocProvider.of<AddFoodBloc>(context).add(
                  AddFoodLoadFood(meal: state.title, date: DateTime.now()));
            }
          },
        ),
        BlocListener<AddFoodBloc, AddFoodState>(
          listener: (context, state) async {
            if (state is AddFoodComplete) {
              if (EasyLoading.isShow) {
                await EasyLoading.dismiss();
              }
              Navigator.of(context).pop();
            } else if (state is AddFoodLoadingFood) {
              EasyLoading.show(
                status: "It takes few minute, please wait",
                maskType: EasyLoadingMaskType.black,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.green,
          title: BlocBuilder<TitleCubit, TitleState>(
            builder: (context, state) {
              if (state is TitleInitial) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: state.title,
                    items: TitleState.mealTitle
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 24,
                            color: AppColors.orangeLight,
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
                  ),
                );
              }
              return const Text("Error bloc");
            },
          ),
        ),
        bottomSheet: BlocBuilder<AddFoodBloc, AddFoodState>(
          builder: (context, state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextButton(
                onPressed: () {
                  if (state is AddFoodHasFood) {
                    BlocProvider.of<AddFoodBloc>(context).add(AddFoodSendFood(
                        foodSearchEntityList: state.foodSearchEntityList,
                        meal: state.meal,
                        date: state.date));
                  } else if (state is AddFoodNoFood) {
                    BlocProvider.of<AddFoodBloc>(context).add(AddFoodSendFood(
                        foodSearchEntityList: const [],
                        meal: state.meal,
                        date: state.date));
                  }
                },
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 24, color: AppColors.white),
                ),
              ),
            );
          },
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
                        if (foodSearch != null) {
                          BlocProvider.of<AddFoodBloc>(context).add(
                              AddFoodAddingFood(
                                  foodSearchEntityList: const [],
                                  foodAdd: foodSearch,
                                  meal: state.meal,
                                  date: state.date));
                        }
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
                                foodSearchEntityList:
                                    state.foodSearchEntityList,
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
                          return GestureDetector(
                            onTap: () {
                              // showBarModalBottomSheet(context: context, builder: (context) {
                              //   return
                              // });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state
                                                  .foodSearchEntityList[index]
                                                  .name,
                                              style: const TextStyle(
                                                  fontSize: 20, height: 1.2),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${state.foodSearchEntityList[index].quantity} portion",
                                                  style: const TextStyle(
                                                      color: AppColors.gray,
                                                      height: 1.2),
                                                ),
                                                Text(
                                                  " - for ${state.foodSearchEntityList[index].type}",
                                                  style: const TextStyle(
                                                    color: AppColors.gray,
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${state.foodSearchEntityList[index].calories} kcal",
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<AddFoodBloc>(context)
                                                .add(AddFoodRemovingFood(
                                              foodSearchEntityList:
                                                  state.foodSearchEntityList,
                                              foodRemove: state
                                                  .foodSearchEntityList[index],
                                              meal: state.meal,
                                              date: state.date,
                                            ));
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: AppColors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
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
