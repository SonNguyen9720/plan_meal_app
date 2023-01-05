import 'package:equatable/equatable.dart';

class FoodSearchEntity extends Equatable {
  final String id;
  final String name;
  final int calories;
  final int quantity;
  final String imageUrl;
  final String type;
  final int fat;
  final int carb;
  final int protein;
  final String shoppingListType;
  final String shoppingListId;
  final String dishType;
  final String note;

  const FoodSearchEntity(
      {required this.id,
      required this.name,
      required this.calories,
      required this.quantity,
      required this.imageUrl,
      this.type = "individual",
      required this.fat,
      required this.carb,
      required this.protein,
      this.shoppingListType = "",
      this.shoppingListId = "",
      required this.dishType,
      this.note = ""});

  @override
  List<Object> get props => [
        id,
        name,
        calories,
        quantity,
        type,
        fat,
        carb,
        protein,
        shoppingListType,
        shoppingListId,
        dishType,
        note
      ];

  FoodSearchEntity copyWith({
    String? id,
    String? name,
    int? calories,
    int? quantity,
    String? imageUrl,
    String? type,
    int? fat,
    int? carb,
    int? protein,
    String? shoppingListType,
    String? shoppingListId,
    String? dishType,
    String? note,
  }) {
    return FoodSearchEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      fat: fat ?? this.fat,
      carb: carb ?? this.carb,
      protein: protein ?? this.protein,
      shoppingListType: shoppingListType ?? this.shoppingListType,
      shoppingListId: shoppingListId ?? this.shoppingListId,
      dishType: dishType ?? this.type,
      note: note ?? this.note,
    );
  }
}
