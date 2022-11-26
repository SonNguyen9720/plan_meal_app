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
