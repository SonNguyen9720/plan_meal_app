class Ingredient {
  String? name;
  int? carbohydrates;
  int? fat;
  int? protein;
  int? calories;
  String? imageUrl;
  int? suggestedPrice;
  String? recipeId;

  Ingredient(
      {this.name,
      this.carbohydrates,
      this.fat,
      this.protein,
      this.calories,
      this.imageUrl,
      this.suggestedPrice,
      this.recipeId});

  Ingredient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    carbohydrates = json['carbohydrates'];
    fat = json['fat'];
    protein = json['protein'];
    calories = json['calories'];
    imageUrl = json['imageUrl'];
    suggestedPrice = json['suggestedPrice'];
    recipeId = json['recipeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['carbohydrates'] = carbohydrates;
    data['fat'] = fat;
    data['protein'] = protein;
    data['calories'] = calories;
    data['imageUrl'] = imageUrl;
    data['suggestedPrice'] = suggestedPrice;
    data['recipeId'] = recipeId;
    return data;
  }
}
