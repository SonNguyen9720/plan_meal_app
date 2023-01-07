import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String id;
  final String location;

  const LocationEntity({required this.id, required this.location});

  @override
  List<Object?> get props => [id, location];

}