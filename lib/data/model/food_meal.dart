import 'package:plan_meal_app/data/model/food.dart';

class FoodMeal {
  int? dishToMenuId;
  int? dishId;
  int? menuId;
  String? meal;
  int? quantity;
  Food? dish;

  FoodMeal(
      {this.dishToMenuId,
        this.dishId,
        this.menuId,
        this.meal,
        this.quantity,
        this.dish});

  FoodMeal.fromJson(Map<String, dynamic> json) {
    dishToMenuId = json['dishToMenuId'];
    dishId = json['dishId'];
    menuId = json['menuId'];
    meal = json['meal'];
    quantity = json['quantity'];
    dish = json['dish'] != null ? Food.fromJson(json['dish']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dishToMenuId'] = dishToMenuId;
    data['dishId'] = dishId;
    data['menuId'] = menuId;
    data['meal'] = meal;
    data['quantity'] = quantity;
    if (dish != null) {
      data['dish'] = dish!.toJson();
    }
    return data;
  }
}
