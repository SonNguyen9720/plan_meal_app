import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/food/add_food_meal/add_sl_to_dish/bloc/add_sl_to_dish_bloc.dart';

class AddSlToDishScreen extends StatelessWidget {
  const AddSlToDishScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Add to shopping list"),
      ),
      bottomSheet: BlocBuilder<AddSlToDishBloc, AddSlToDishState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: state is AddSlToDishChosen ? AppColors.green : AppColors.grey300,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: TextButton(
              onPressed: state is AddSlToDishChosen? () {
                Map<String, dynamic> result = {
                  'id': state.slList[state.index].slId,
                  'type': state.slList[state.index].type,
                  'name': state.slList[state.index].name,
                };
                Navigator.pop(context, result);
              } : null,
              child: const Text(
                "Done",
                style: TextStyle(fontSize: 24, color: AppColors.white),
              ),
            ),
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: BlocBuilder<AddSlToDishBloc, AddSlToDishState>(
          builder: (context, state) {
            if (state is AddSlToDishLoaded) {
              return Column(
                children: [
                  buildHeading(context),
                  const Divider(),
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.slList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<AddSlToDishBloc>(context)
                                    .add(AddSlToDishSelectEvent(index: index));
                              },
                              child: buildTile(state.slList[index].name,
                                  state.slList[index].date, false),
                            );
                          })),
                ],
              );
            } else if (state is AddSlToDishLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AddSlToDishChosen) {
              return Column(
                children: [
                  buildHeading(context),
                  const Divider(),
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.slList.length,
                          itemBuilder: (context, index) {
                            bool isSelect = index == state.index;
                            return GestureDetector(
                              onTap: () {
                                if (index == state.index) {
                                  BlocProvider.of<AddSlToDishBloc>(context)
                                      .add(AddSlToDishDeselectEvent());
                                } else {
                                  BlocProvider.of<AddSlToDishBloc>(context).add(
                                      AddSlToDishSelectEvent(index: index));
                                }
                              },
                              child: buildTile(state.slList[index].name,
                                  state.slList[index].date, isSelect),
                            );
                          })),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    ));
  }

  Widget buildTile(String name, String date, bool isSelect) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        tileColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isSelect
                ? const BorderSide(color: AppColors.green, width: 3)
                : BorderSide.none),
        title: Text(name),
        subtitle: Text(date),
      ),
    );
  }

  Widget buildHeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(
              child: Text(
            "Shopping lists",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 16, color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
