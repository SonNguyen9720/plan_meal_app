import 'package:equatable/equatable.dart';

class IngredientByDayEntity extends Equatable {
  final String ingredientIdToShoppingList;
  final String id;
  final String name;
  final String imageUrl;
  final int quantity;
  final int weight;
  final String measurement;
  final bool checked;
  final String type;

  const IngredientByDayEntity(
      {required this.ingredientIdToShoppingList,
      required this.id,
      required this.name,
      required this.imageUrl,
      required this.quantity,
      required this.weight,
      required this.measurement,
      required this.checked,
      required this.type});

  @override
  List<Object?> get props => [
        ingredientIdToShoppingList,
        id,
        name,
        imageUrl,
        quantity,
        measurement,
        checked
      ];

  IngredientByDayEntity updateChecked({bool? checked}) {
    return IngredientByDayEntity(
      ingredientIdToShoppingList: ingredientIdToShoppingList,
      id: id,
      name: name,
      imageUrl: imageUrl,
      quantity: quantity,
      weight: weight,
      measurement: measurement,
      checked: checked ?? this.checked,
      type: type,
    );
  }
}
