import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/entities/food_search_entity.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';

const List<String> type = <String>["individual", "group"];
const List<String> method = <String>["cooking", "buying", "eat-outside"];

class AddFoodDetailScreen extends StatefulWidget {
  final FoodSearchEntity foodSearchEntity;

  const AddFoodDetailScreen({Key? key, required this.foodSearchEntity})
      : super(key: key);

  @override
  State<AddFoodDetailScreen> createState() => _AddFoodDetailScreenState();
}

class _AddFoodDetailScreenState extends State<AddFoodDetailScreen> {
  late int quantity;
  String dropdownValue = type.first;
  String methodValue = method.first;
  bool isAddShoppingCart = true;
  String name = "";
  String shoppingListId = "";

  @override
  void initState() {
    quantity = widget.foodSearchEntity.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
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
              TextFormField(
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
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
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
              ...buildPurpose(),
              buildShoppingList(),
              TextFormField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                  filled: true,
                  labelText: "Note",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    decoration: const BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: TextButton(
                      onPressed: () {
                        Map<String, dynamic> objectReturn = {
                          "quantity": quantity,
                          "type": dropdownValue,
                        };
                        Navigator.of(context).pop(objectReturn);
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 28,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
          child: Text(value),
          value: value,
        );
      }).toList();
    }
    return <DropdownMenuItem<String>>[
      DropdownMenuItem<String>(
        child: Text(type.first),
        value: type.first,
      ),
    ];
  }

  List<Widget> buildPurpose() {
    return [
      const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          "Purpose",
          style: TextStyle(fontSize: 16),
        ),
      ),
      const Divider(),
      RadioListTile<String>(
        title: const Text("Cooking"),
        value: method.first,
        groupValue: methodValue,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              methodValue = value;
              isAddShoppingCart = true;
            });
          }
        },
        activeColor: AppColors.green,
      ),
      RadioListTile<String>(
        title: const Text("Buying"),
        value: method[1],
        groupValue: methodValue,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              methodValue = value;
              isAddShoppingCart = true;
            });
          }
        },
        activeColor: AppColors.green,
      ),
      RadioListTile<String>(
        title: const Text("Eat outside"),
        value: method.last,
        groupValue: methodValue,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              methodValue = value;
              isAddShoppingCart = false;
            });
          }
        },
        activeColor: AppColors.green,
      ),
    ];
  }

  Widget buildShoppingList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text(
                "Add to shopping list",
                style: TextStyle(fontSize: 16),
              )),
              GestureDetector(
                onTap: () async {
                  if (isAddShoppingCart) {
                    var result = await Navigator.of(context)
                        .pushNamed(PlanMealRoutes.foodAddSL);
                    if (result != null) {
                      setState(() {
                        name = (result as Map<String, dynamic>)['name'];
                        shoppingListId = result['id'];
                      });
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                    color:
                        isAddShoppingCart ? AppColors.green : AppColors.grey300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(
                        fontSize: 16,
                        color: isAddShoppingCart
                            ? AppColors.white
                            : AppColors.gray),
                  ),
                ),
              ),
            ],
          ),
          (name.isNotEmpty && isAddShoppingCart)
              ? Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                )
              : Container(),
        ],
      ),
    );
  }
}
