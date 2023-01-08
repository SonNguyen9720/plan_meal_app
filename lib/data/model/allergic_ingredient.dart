class AllergicIngredient {
  int? id;
  String? createdAt;
  String? updatedAt;
  Ingredient? ingredient;
  UserIngredient? user;

  AllergicIngredient(
      {this.id, this.createdAt, this.updatedAt, this.ingredient, this.user});

  AllergicIngredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ingredient = json['ingredient'] != null
        ? Ingredient.fromJson(json['ingredient'])
        : null;
    user = json['user'] != null ? UserIngredient.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (ingredient != null) {
      data['ingredient'] = ingredient!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Ingredient {
  int? id;
  String? name;
  int? carbohydrates;
  int? fat;
  int? protein;
  int? calories;
  String? imageUrl;
  int? suggestedPrice;
  String? createdAt;
  String? updatedAt;

  Ingredient(
      {this.id,
        this.name,
        this.carbohydrates,
        this.fat,
        this.protein,
        this.calories,
        this.imageUrl,
        this.suggestedPrice,
        this.createdAt,
        this.updatedAt});

  Ingredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    carbohydrates = json['carbohydrates'];
    fat = json['fat'];
    protein = json['protein'];
    calories = json['calories'];
    imageUrl = json['imageUrl'];
    suggestedPrice = json['suggestedPrice'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['carbohydrates'] = carbohydrates;
    data['fat'] = fat;
    data['protein'] = protein;
    data['calories'] = calories;
    data['imageUrl'] = imageUrl;
    data['suggestedPrice'] = suggestedPrice;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class UserIngredient {
  int? id;
  int? height;
  int? weight;
  String? healthGoal;
  int? desiredWeight;
  String? activityIntensity;
  String? createdAt;
  String? updatedAt;
  bool? active;
  String? role;

  UserIngredient(
      {this.id,
        this.height,
        this.weight,
        this.healthGoal,
        this.desiredWeight,
        this.activityIntensity,
        this.createdAt,
        this.updatedAt,
        this.active,
        this.role});

  UserIngredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    height = json['height'];
    weight = json['weight'];
    healthGoal = json['healthGoal'];
    desiredWeight = json['desiredWeight'];
    activityIntensity = json['activityIntensity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    active = json['active'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['height'] = height;
    data['weight'] = weight;
    data['healthGoal'] = healthGoal;
    data['desiredWeight'] = desiredWeight;
    data['activityIntensity'] = activityIntensity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['active'] = active;
    data['role'] = role;
    return data;
  }
}
