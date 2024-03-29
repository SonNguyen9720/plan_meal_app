import 'package:equatable/equatable.dart';

class SlFoodEntity extends Equatable {
  final String slId;
  final String type;
  final String name;
  final String date;

  const SlFoodEntity({required this.slId, required this.type, required this.name, required this.date});
  @override
  List<Object?> get props => [slId, type, name, date];
}