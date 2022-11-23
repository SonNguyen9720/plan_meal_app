part of 'scan_food_bloc.dart';

abstract class ScanFoodState extends Equatable {
  @override
  List<Object> get props => [];
}

class ScanFoodInitial extends ScanFoodState {}

class ScanFoodLoading extends ScanFoodState {}

class ScanFoodLoadImage extends ScanFoodState {
  final String imageUrl;
  final List<FoodDetectEntity> foodDetectEntity;

  ScanFoodLoadImage({required this.imageUrl, required this.foodDetectEntity});

  @override
  List<Object> get props => [imageUrl, foodDetectEntity];
}

class ScanFoodNoImage extends ScanFoodState {
  final String imageUrl;

  ScanFoodNoImage({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}
