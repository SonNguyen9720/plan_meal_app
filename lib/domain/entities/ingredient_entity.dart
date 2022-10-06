import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final String name;
  final int quantity;

  const Ingredient({required this.name, this.quantity = 0});

  @override
  List<Object?> get props => [];
}
