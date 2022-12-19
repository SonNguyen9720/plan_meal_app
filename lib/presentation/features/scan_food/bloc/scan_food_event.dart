part of 'scan_food_bloc.dart';

abstract class ScanFoodEvent extends Equatable {
  const ScanFoodEvent();

  @override
  List<Object> get props => [];
}

class ScanFoodChooseImageFromCameraEvent extends ScanFoodEvent {}

class ScanFoodChooseImageFromGalleryEvent extends ScanFoodEvent {}

class ScanFoodRescanEvent extends ScanFoodEvent {}