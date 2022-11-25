import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/food/create_food/bloc/create_food_bloc.dart';

class CreateFoodScreen extends StatefulWidget {
  const CreateFoodScreen({Key? key}) : super(key: key);

  @override
  State<CreateFoodScreen> createState() => _CreateFoodScreenState();
}

class _CreateFoodScreenState extends State<CreateFoodScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController carbController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateFoodBloc, CreateFoodState>(
      listener: (BuildContext context, state) async {
        if (state is CreateFoodLoading) {
          EasyLoading.show(
            status: "It takes few minute, please wait",
            maskType: EasyLoadingMaskType.black,
          );
        } else if (state is CreateFoodFinished) {
          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }
          Navigator.of(context).pop();
        } else {
          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Create new food",
            style: TextStyle(fontSize: 24),
          ),
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                  child: TextButton(
                onPressed: () {
                  BlocProvider.of<CreateFoodBloc>(context).add(
                      CreateFoodAddFood(
                          name: nameController.text,
                          carb: int.parse(carbController.text),
                          fat: int.parse(fatController.text),
                          protein: int.parse(proteinController.text),
                          calories: int.parse(caloriesController.text)));
                },
                child: const Text(
                  "Create",
                  style: TextStyle(fontSize: 20),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  primary: AppColors.white,
                ),
              ))
            ],
          ),
        ),
        body: Form(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Name",
                    labelStyle: TextStyle(color: AppColors.green),
                    fillColor: AppColors.greenPastel,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: proteinController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    labelText: "Protein",
                    labelStyle: TextStyle(color: AppColors.green),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    suffixText: "g",
                    suffixStyle: TextStyle(fontSize: 16),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: fatController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    labelText: "Fat",
                    labelStyle: TextStyle(color: AppColors.green),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    suffixText: "g",
                    suffixStyle: TextStyle(fontSize: 16),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: carbController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    labelText: "Carb",
                    labelStyle: TextStyle(color: AppColors.green),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    suffixText: "g",
                    suffixStyle: TextStyle(fontSize: 16),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: caloriesController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    labelText: "Calories",
                    labelStyle: TextStyle(color: AppColors.green),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green),
                    ),
                    suffixText: "kcal",
                    suffixStyle: TextStyle(fontSize: 16),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
