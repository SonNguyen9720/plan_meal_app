import 'package:equatable/equatable.dart';

class IngredientByDay extends Equatable {
  int? id;
  String? name;
  String? address;
  String? longitude;
  String? latitude;
  String? createdAt;
  String? updatedAt;
  List<IngredientCategories>? ingredientCategories;

  IngredientByDay(
      {this.id,
      this.name,
      this.address,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.updatedAt,
      this.ingredientCategories});

  IngredientByDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['ingredientCategories'] != null) {
      ingredientCategories = <IngredientCategories>[];
      json['ingredientCategories'].forEach((v) {
        ingredientCategories!.add(IngredientCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (ingredientCategories != null) {
      data['ingredientCategories'] =
          ingredientCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props =>
      [id, name, address, longitude, latitude, createdAt, updatedAt];
}

class IngredientCategories extends Equatable {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Ingredients>? ingredients;

  IngredientCategories(
      {this.id, this.name, this.createdAt, this.updatedAt, this.ingredients});

  IngredientCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt, ingredients];
}

class Ingredients extends Equatable {
  int? ingredientToShoppingListId;
  int? quantity;
  bool? checked;
  String? note;
  String? createdAt;
  String? updatedAt;
  Ingredient? ingredient;
  IngredientCategory? measurementType;
  Location? location;

  Ingredients(
      {this.ingredientToShoppingListId,
      this.quantity,
      this.checked,
      this.note,
      this.createdAt,
      this.updatedAt,
      this.ingredient,
      this.measurementType,
      this.location});

  Ingredients.fromJson(Map<String, dynamic> json) {
    ingredientToShoppingListId = json['ingredientToShoppingListId'];
    quantity = json['quantity'];
    checked = json['checked'];
    note = json['note'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ingredient = json['ingredient'] != null
        ? Ingredient.fromJson(json['ingredient'])
        : null;
    measurementType = json['measurementType'] != null
        ? IngredientCategory.fromJson(json['measurementType'])
        : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ingredientToShoppingListId'] = ingredientToShoppingListId;
    data['quantity'] = quantity;
    data['checked'] = checked;
    data['note'] = note;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (ingredient != null) {
      data['ingredient'] = ingredient!.toJson();
    }
    if (measurementType != null) {
      data['measurementType'] = measurementType!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        ingredientToShoppingListId,
        quantity,
        checked,
        note,
        createdAt,
        updatedAt,
        ingredient,
        measurementType,
        location,
      ];
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
  IngredientCategory? ingredientCategory;

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
      this.updatedAt,
      this.ingredientCategory});

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
    ingredientCategory = json['ingredientCategory'] != null
        ? IngredientCategory.fromJson(json['ingredientCategory'])
        : null;
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
    if (ingredientCategory != null) {
      data['ingredientCategory'] = ingredientCategory!.toJson();
    }
    return data;
  }
}

class IngredientCategory {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  IngredientCategory({this.id, this.name, this.createdAt, this.updatedAt});

  IngredientCategory.fromJson(Map<String, dynamic> json) {
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

class Location {
  int? id;
  String? name;
  String? address;
  String? longitude;
  String? latitude;
  String? createdAt;
  String? updatedAt;

  Location(
      {this.id,
      this.name,
      this.address,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.updatedAt});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
