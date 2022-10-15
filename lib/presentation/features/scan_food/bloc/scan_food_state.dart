part of 'scan_food_bloc.dart';

abstract class ScanFoodState extends Equatable {
  const ScanFoodState();

  @override
  List<Object> get props => [];
}

class ScanFoodInitial extends ScanFoodState {}

class ScanFoodLoadingCamera extends ScanFoodState {}

class ScanFoodLoadedCamera extends ScanFoodState {}
