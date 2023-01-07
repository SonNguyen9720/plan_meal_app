import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String id;
  final String location;
  final String address;

  const LocationEntity({required this.id, required this.location, this.address = ""});

  @override
  List<Object?> get props => [id, location];

}