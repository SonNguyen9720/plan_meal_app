import 'package:equatable/equatable.dart';

class IngredientByDayEntity extends Equatable {
  final String name;
  final String imageUrl;
  final int quantity;
  final String measurement;
  final bool checked;
  final String type;

  const IngredientByDayEntity(
      {required this.name,
      required this.imageUrl,
      required this.quantity,
      required this.measurement,
      required this.checked,
      required this.type});

  @override
  List<Object?> get props => [name, imageUrl, quantity, measurement, checked];
}
