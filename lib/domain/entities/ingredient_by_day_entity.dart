import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/measurement_model.dart';

class IngredientByDayEntity extends Equatable {
  final String ingredientIdToShoppingList;
  final String id;
  final String name;
  final String imageUrl;
  final int quantity;
  final MeasurementModel measurement;
  final bool checked;
  final String type;

  const IngredientByDayEntity(
      {required this.ingredientIdToShoppingList,
      required this.id,
      required this.name,
      required this.imageUrl,
      required this.quantity,
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
      measurement: measurement,
      checked: checked ?? this.checked,
      type: type,
    );
  }
}
