import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/measurement_model.dart';
import 'package:plan_meal_app/domain/entities/location_entity.dart';

class IngredientByDayEntity extends Equatable {
  final String ingredientIdToShoppingList;
  final String id;
  final String name;
  final String imageUrl;
  final int quantity;
  final MeasurementModel measurement;
  final bool checked;
  final String type;
  final LocationEntity location;
  final String note;

  const IngredientByDayEntity({
    required this.ingredientIdToShoppingList,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.measurement,
    required this.checked,
    required this.type,
    required this.location,
    required this.note,
  });

  @override
  List<Object?> get props => [
        ingredientIdToShoppingList,
        id,
        name,
        imageUrl,
        quantity,
        measurement,
        checked,
        type,
        location,
        note
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
      note: note,
      location: location,
    );
  }
}
