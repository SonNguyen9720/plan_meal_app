class UserFood {
  int? id;
  String? createdAt;
  String? updatedAt;
  Dish? dish;

  UserFood({this.id, this.createdAt, this.updatedAt, this.dish});

  UserFood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    dish = json['dish'] != null ? new Dish.fromJson(json['dish']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.dish != null) {
      data['dish'] = this.dish!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['carbohydrates'] = this.carbohydrates;
    data['fat'] = this.fat;
    data['protein'] = this.protein;
    data['calories'] = this.calories;
    data['imageUrl'] = this.imageUrl;
    data['recipe'] = this.recipe;
    data['cookingTime'] = this.cookingTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
