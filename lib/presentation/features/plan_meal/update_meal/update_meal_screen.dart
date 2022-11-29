import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/food_repository_remote.dart';
import 'package:plan_meal_app/domain/entities/food_meal_entity.dart';

const List<String> type = <String>["individual", "group"];

class UpdateMealScreen extends StatefulWidget {
  final FoodMealEntity foodMealEntity;

  const UpdateMealScreen({Key? key, required this.foodMealEntity})
      : super(key: key);

  @override
  State<UpdateMealScreen> createState() => _UpdateMealScreenState();
}

class _UpdateMealScreenState extends State<UpdateMealScreen> {
  final FoodRepositoryRemote foodRepositoryRemote = FoodRepositoryRemote();

  late int quantity;
  String dropdownValue = type.first;

  @override
  void initState() {
    quantity = widget.foodMealEntity.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.foodMealEntity.name,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.orangeLight,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: AppColors.red,
                      ),
                      Text(
                        getTotalNutrition(
                            int.parse(widget.foodMealEntity.calories)) +
                            " kcal",
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: AppColors.greenPastel,
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${getTotalNutrition(
                                widget.foodMealEntity.protein)} g",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Proteins",
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${getTotalNutrition(widget.foodMealEntity.fat)} g",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Fat",
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${getTotalNutrition(
                                widget.foodMealEntity.carb)} g",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Carb",
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  const Text(
                    "Serving size",
                    style: TextStyle(fontSize: 24),
                  ),
                  RichText(
                      text: TextSpan(
                        text: "$quantity",
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 18),
                        children: const [
                          TextSpan(
                              text: " x",
                              style: TextStyle(color: AppColors.gray,
                                  fontSize: 18)),
                          TextSpan(
                              text: " 1 portion",
                              style: TextStyle(color: AppColors.black,
                                  fontSize: 18)),
                        ],
                      )),
                ],
              ),
            ),
            TextFormField(
              initialValue: widget.foodMealEntity.quantity.toString(),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    quantity = 0;
                  } else {
                    quantity = int.parse(value);
                  }
                });
              },
              decoration: const InputDecoration(
                filled: true,
                labelText: "Number of serving",
                labelStyle: TextStyle(color: AppColors.green),
                fillColor: AppColors.greenPastel,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.green),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.green),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: DropdownButtonFormField<String>(
                value: dropdownValue,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16)),
                  ),
                  filled: true,
                  fillColor: AppColors.greenPastel,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green),
                  ),
                  labelText: "Type",
                  labelStyle: TextStyle(color: AppColors.green),
                ),
                isExpanded: true,
                elevation: 16,
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: type.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: const BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: TextButton(
              onPressed: () async {
                await foodRepositoryRemote.updateFood(
                    widget.foodMealEntity.foodId.toString(),
                    widget.foodMealEntity.meal, quantity);
                Navigator.of(context).pop();
              },
              child: const Text("Update", style: TextStyle(
                fontSize: 28,
                color: AppColors.white,
              ),),
            ),
          ),
        ],
      ),
    );
  }

  String getTotalNutrition(int nutrition) {
    var result = nutrition * quantity;
    return result.toString();
  }
}
