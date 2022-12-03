class UserOverview {
  double? baseCalories;
  int? currentCalories;
  int? totalCalories;
  int? protein;
  int? fat;
  int? carb;

  UserOverview(
      {this.baseCalories,
        this.currentCalories,
        this.totalCalories,
        this.protein,
        this.fat,
        this.carb});

  UserOverview.fromJson(Map<String, dynamic> json) {
    baseCalories = json['baseCalories'];
    currentCalories = json['currentCalories'];
    totalCalories = json['totalCalories'];
    protein = json['protein'];
    fat = json['fat'];
    carb = json['carb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baseCalories'] = baseCalories;
    data['currentCalories'] = currentCalories;
    data['totalCalories'] = totalCalories;
    data['protein'] = protein;
    data['fat'] = fat;
    data['carb'] = carb;
    return data;
  }
}
