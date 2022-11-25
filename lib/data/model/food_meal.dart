

import 'package:plan_meal_app/data/model/food.dart';

class FoodMeal {
  int? dishToMenuId;
  int? dishId;
  int? menuId;
  String? meal;
  int? quantity;
  String? type;
  bool? tracked;
  Food? dish;

  FoodMeal(
      {this.dishToMenuId,
        this.dishId,
        this.menuId,
        this.meal,
        this.quantity,
        this.type,
        this.tracked,
        this.dish});

  FoodMeal.fromJson(Map<String, dynamic> json) {
    dishToMenuId = json['dishToMenuId'];
    dishId = json['dishId'];
    menuId = json['menuId'];
    meal = json['meal'];
    quantity = json['quantity'];
    type = json['type'];
    tracked = json['tracked'];
    dish = json['dish'] != null ? Food.fromJson(json['dish']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dishToMenuId'] = dishToMenuId;
    data['dishId'] = dishId;
    data['menuId'] = menuId;
    data['meal'] = meal;
    data['quantity'] = quantity;
    data['type'] = type;
    data['tracked'] = tracked;
    if (dish != null) {
      data['dish'] = dish!.toJson();
    }
    return data;
  }
}
