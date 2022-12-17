import 'package:equatable/equatable.dart';

class WeightEntity extends Equatable {
  final DateTime date;
  final int weight;

  const WeightEntity({required this.date, required this.weight});

  @override
  List<Object?> get props => [date, weight];
}