import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/measurement_model.dart';
import 'package:plan_meal_app/domain/entities/location_entity.dart';

class IngredientDetailEntity extends Equatable {
  final String ingredientId;
  final String name;
  final int calories;
  final int quantity;
  final MeasurementModel measurementType;
  final String type;
  final String imageUrl;
  final LocationEntity location;
  final String note;

  const IngredientDetailEntity({
    required this.ingredientId,
    required this.name,
    required this.calories,
    this.quantity = 1,
    required this.measurementType,
    this.type = "individual",
    required this.imageUrl,
    this.note = "",
    required this.location,
  });

  @override
  List<Object?> get props =>
      [ingredientId, name, quantity, measurementType, type, imageUrl, location, note];

  IngredientDetailEntity copyWith({
    String? ingredientId,
    String? name,
    int? calories,
    int? quantity,
    MeasurementModel? measurementType,
    String? type,
    String? imageUrl,
    LocationEntity? location,
    String? note,
  }) {
    return IngredientDetailEntity(
      ingredientId: ingredientId ?? this.ingredientId,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      quantity: quantity ?? this.quantity,
      measurementType: measurementType ?? this.measurementType,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      note: note ?? this.note,
    );
  }
}
