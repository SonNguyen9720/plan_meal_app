class FoodMeal {
  int? dishToMenuId;
  int? quantity;
  String? type;
  bool? tracked;
  String? dishType;
  String? note;
  String? createdAt;
  String? updatedAt;
  Dish? dish;
  Meal? meal;

  FoodMeal(
      {this.dishToMenuId,
        this.quantity,
        this.type,
        this.tracked,
        this.dishType,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.dish,
        this.meal});

  FoodMeal.fromJson(Map<String, dynamic> json) {
    dishToMenuId = json['dishToMenuId'];
    quantity = json['quantity'];
    type = json['type'];
    tracked = json['tracked'];
    dishType = json['dishType'];
    note = json['note'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    dish = json['dish'] != null ? Dish.fromJson(json['dish']) : null;
    meal = json['meal'] != null ? Meal.fromJson(json['meal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dishToMenuId'] = dishToMenuId;
    data['quantity'] = quantity;
    data['type'] = type;
    data['tracked'] = tracked;
    data['dishType'] = dishType;
    data['note'] = note;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (dish != null) {
      data['dish'] = dish!.toJson();
    }
    if (meal != null) {
      data['meal'] = meal!.toJson();
    }
    return data;
  }
}

class Dish {
  int? id;
  String? name;
  String? description;
  String? slug;
  int? carbohydrates;
  int? fat;
  int? protein;
  int? calories;
  String? imageUrl;
  String? recipe;
  int? cookingTime;
  String? createdAt;
  String? updatedAt;

  Dish(
      {this.id,
        this.name,
        this.description,
        this.slug,
        this.carbohydrates,
        this.fat,
        this.protein,
        this.calories,
        this.imageUrl,
        this.recipe,
        this.cookingTime,
        this.createdAt,
        this.updatedAt});

  Dish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    carbohydrates = json['carbohydrates'];
    fat = json['fat'];
    protein = json['protein'];
    calories = json['calories'];
    imageUrl = json['imageUrl'];
    recipe = json['recipe'];
    cookingTime = json['cookingTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['slug'] = slug;
    data['carbohydrates'] = carbohydrates;
    data['fat'] = fat;
    data['protein'] = protein;
    data['calories'] = calories;
    data['imageUrl'] = imageUrl;
    data['recipe'] = recipe;
    data['cookingTime'] = cookingTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Meal {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Meal({this.id, this.name, this.createdAt, this.updatedAt});

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
