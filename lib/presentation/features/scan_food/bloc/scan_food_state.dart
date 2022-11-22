part of 'scan_food_bloc.dart';

abstract class ScanFoodState extends Equatable {
  @override
  List<Object> get props => [];
}

class ScanFoodInitial extends ScanFoodState {}

class ScanFoodLoadImage extends ScanFoodState {
  final String imageUrl;

  ScanFoodLoadImage({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}
