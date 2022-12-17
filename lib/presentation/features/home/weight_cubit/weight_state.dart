part of 'weight_cubit.dart';

abstract class WeightState extends Equatable {
  const WeightState();
}

class WeightInitial extends WeightState {
  final List<WeightEntity> weightList;

  const WeightInitial({this.weightList = const []});

  @override
  List<Object> get props => [];
}
