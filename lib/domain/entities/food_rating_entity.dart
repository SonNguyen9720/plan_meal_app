import 'package:equatable/equatable.dart';

class FoodRatingEntity extends Equatable {
  final String foodId;
  final String name;
  final bool isSelected;
  final bool isLiked;

  const FoodRatingEntity(
      {required this.foodId,
      required this.name,
      required this.isLiked,
      required this.isSelected});

  @override
  List<Object?> get props => [foodId, name, isSelected, isLiked];

  FoodRatingEntity copyWith(
      {String? foodId, String? name, bool? isSelected, bool? isLiked}) {
    return FoodRatingEntity(
      foodId: foodId ?? this.foodId,
      name: name ?? this.name,
      isLiked: isLiked ?? this.isLiked,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
