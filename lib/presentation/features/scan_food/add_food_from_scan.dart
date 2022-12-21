import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/local/meal_list.dart';
import 'package:plan_meal_app/data/model/meal_model.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/food_repository_remote.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/food_search_entity.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/string_utils.dart';

const List<String> type = <String>["individual", "group"];
const List<String> meal = <String>["breakfast", "lunch", "dinner"];

class AddFoodFromScan extends StatefulWidget {
  final FoodSearchEntity foodSearchEntity;

  const AddFoodFromScan({Key? key, required this.foodSearchEntity})
      : super(key: key);

  @override
  State<AddFoodFromScan> createState() => _AddFoodFromScanState();
}

class _AddFoodFromScanState extends State<AddFoodFromScan> {
  late int quantity;
  String dropdownValue = type.first;
  MealModel mealValue = mealList.first;
  DateTime date = DateTime.now();
  TextEditingController dateController =
      TextEditingController(text: DateTimeUtils.parseDateTime(DateTime.now()));
  FoodRepositoryRemote foodRepositoryRemote = FoodRepositoryRemote();

  @override
  void initState() {
    quantity = 1;
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.foodSearchEntity.name,
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: AppColors.red,
                        ),
                        Text(
                          getTotalNutrition(widget.foodSearchEntity.calories) +
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
                              "${getTotalNutrition(widget.foodSearchEntity.protein)} g",
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
                              "${getTotalNutrition(widget.foodSearchEntity.fat)} g",
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
                              "${getTotalNutrition(widget.foodSearchEntity.carb)} g",
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
                      style:
                          const TextStyle(color: AppColors.black, fontSize: 18),
                      children: const [
                        TextSpan(
                            text: " x",
                            style:
                                TextStyle(color: AppColors.gray, fontSize: 18)),
                        TextSpan(
                            text: " 1 portion",
                            style: TextStyle(
                                color: AppColors.black, fontSize: 18)),
                      ],
                    )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  initialValue: widget.foodSearchEntity.quantity.toString(),
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
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  controller: dateController,
                  // initialValue: DateTimeUtils.parseDateTime(DateTime.now()),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)) ??
                        DateTime.now();
                    dateController.text = DateTimeUtils.parseDateTime(date);
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Date",
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
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: DropdownButtonFormField<String>(
                    value: dropdownValue,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
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
                    items: getDropdownMenu(),
                  )),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: DropdownButtonFormField<MealModel>(
                    value: mealValue,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      filled: true,
                      fillColor: AppColors.greenPastel,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.green),
                      ),
                      labelText: "Meal",
                      labelStyle: TextStyle(color: AppColors.green),
                    ),
                    isExpanded: true,
                    elevation: 16,
                    onChanged: (value) {
                      setState(() {
                        mealValue = value!;
                      });
                    },
                    items: mealList.map<DropdownMenuItem<MealModel>>((value) {
                      return DropdownMenuItem<MealModel>(
                        child: Text(value.meal),
                        value: value,
                      );
                    }).toList(),
                  )),
            ],
          ),
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
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: TextButton(
              onPressed: () async {
                EasyLoading.show(
                  status: "Loading ...",
                  maskType: EasyLoadingMaskType.black,
                );
                await foodRepositoryRemote.addMealFood(widget.foodSearchEntity.id,
                    dropdownValue, dateController.text, mealValue.id,
                    quantity: quantity);
                await EasyLoading.dismiss();
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: const Text("Success"),
                    content: const Text("Your dish has add to plan"),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pushReplacementNamed(context, PlanMealRoutes.scan);
                      }, child: const Text("OK"))
                    ],
                  );
                });
                // Navigator.of(context).pushReplacementNamed(PlanMealRoutes.scan);
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 28,
                  color: AppColors.white,
                ),
              ),
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

  List<DropdownMenuItem<String>> getDropdownMenu() {
    String groupId = PreferenceUtils.getString("groupId") ?? "";
    if (groupId.isNotEmpty) {
      return type.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          child: Text(StringUtils.capitalizeFirstChar(value)),
          value: value,
        );
      }).toList();
    }
    return <DropdownMenuItem<String>>[
      DropdownMenuItem<String>(
        child: Text(StringUtils.capitalizeFirstChar(type.first)),
        value: type.first,
      ),
    ];
  }
}
