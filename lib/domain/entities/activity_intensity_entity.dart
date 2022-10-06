import 'package:equatable/equatable.dart';

class ActivityIntensityEntity extends Equatable {
  final String title;
  final String description;

  const ActivityIntensityEntity(
      {required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}
