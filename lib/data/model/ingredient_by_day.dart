class IngredientByDay {
  int? ingredientToShoppingListId;
  int? quantity;
  bool? checked;
  String? note;
  String? createdAt;
  String? updatedAt;
  Ingredient? ingredient;
  MeasurementType? measurementType;
  MeasurementType? location;

  IngredientByDay(
      {this.ingredientToShoppingListId,
        this.quantity,
        this.checked,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.ingredient,
        this.measurementType,
        this.location});

  IngredientByDay.fromJson(Map<String, dynamic> json) {
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
        ? MeasurementType.fromJson(json['measurementType'])
        : null;
    location = json['location'] != null
        ? MeasurementType.fromJson(json['location'])
        : null;
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

class MeasurementType {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  MeasurementType({this.id, this.name, this.createdAt, this.updatedAt});

  MeasurementType.fromJson(Map<String, dynamic> json) {
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
