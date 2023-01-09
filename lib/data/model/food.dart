class Food {
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
  FoodCategory? foodCategory;

  Food(
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
        this.updatedAt,
        this.foodCategory});

  Food.fromJson(Map<String, dynamic> json) {
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
    foodCategory = json['foodCategory'] != null
        ? FoodCategory.fromJson(json['foodCategory'])
        : null;
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
    if (foodCategory != null) {
      data['foodCategory'] = foodCategory!.toJson();
    }
    return data;
  }
}

class FoodCategory {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  FoodCategory({this.id, this.name, this.createdAt, this.updatedAt});

  FoodCategory.fromJson(Map<String, dynamic> json) {
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
