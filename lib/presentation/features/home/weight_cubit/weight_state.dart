part of 'weight_cubit.dart';

abstract class WeightState extends Equatable {
  const WeightState();
}

class WeightInitial extends WeightState {
  final List<WeightEntity> weightList;
  final int max;
  final int min;

  const WeightInitial({this.weightList = const [], this.max = 80, this.min = 40});

  @override
  List<Object> get props => [];
}
