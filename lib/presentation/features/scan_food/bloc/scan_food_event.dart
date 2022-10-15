part of 'scan_food_bloc.dart';

abstract class ScanFoodEvent extends Equatable {
  const ScanFoodEvent();

  @override
  List<Object> get props => [];
}

class InitCameraEvent extends ScanFoodEvent {
  final bool isSuccess;

  const InitCameraEvent(this.isSuccess);
}
