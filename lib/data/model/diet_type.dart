import 'package:equatable/equatable.dart';

class DietType extends Equatable {
  final String title;
  final String description;

  const DietType(this.title, this.description);

  @override
  List<Object?> get props => [title, description];
}
