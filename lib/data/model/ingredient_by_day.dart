class IngredientByDay {
  int? ingredientToShoppingListId;
  int? ingredientId;
  int? shoppingListId;
  int? quantity;
  String? measurementType;
  int? weight;
  bool? checked;
  Ingredient? ingredient;

  IngredientByDay(
      {this.ingredientToShoppingListId,
        this.ingredientId,
        this.shoppingListId,
        this.quantity,
        this.measurementType,
        this.weight,
        this.checked,
        this.ingredient});

  IngredientByDay.fromJson(Map<String, dynamic> json) {
    ingredientToShoppingListId = json['ingredientToShoppingListId'];
    ingredientId = json['ingredientId'];
    shoppingListId = json['shoppingListId'];
    quantity = json['quantity'];
    measurementType = json['measurementType'];
    weight = json['weight'];
    checked = json['checked'];
    ingredient = json['ingredient'] != null
        ? Ingredient.fromJson(json['ingredient'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ingredientToShoppingListId'] = ingredientToShoppingListId;
    data['ingredientId'] = ingredientId;
    data['shoppingListId'] = shoppingListId;
    data['quantity'] = quantity;
    data['measurementType'] = measurementType;
    data['weight'] = weight;
    data['checked'] = checked;
    if (ingredient != null) {
      data['ingredient'] = ingredient!.toJson();
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
