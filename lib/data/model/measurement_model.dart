import 'package:equatable/equatable.dart';

class MeasurementModel extends Equatable {
  final String id;
  final String measurement;

  const MeasurementModel({required this.id, required this.measurement});

  @override
  List<Object> get props => [id, measurement];
}