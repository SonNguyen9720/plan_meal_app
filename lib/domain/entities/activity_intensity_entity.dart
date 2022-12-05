import 'package:equatable/equatable.dart';

enum ActivityIntensity {
  sedentary,
  lightly_active,
  moderately_active,
  very_active,
  extra_active,
  empty
}

class ActivityIntensityEntity extends Equatable {
  final String title;
  final String description;

  const ActivityIntensityEntity(
      {required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}
