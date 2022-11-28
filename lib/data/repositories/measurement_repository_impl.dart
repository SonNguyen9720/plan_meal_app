import 'package:plan_meal_app/data/model/measurement.dart';
import 'package:plan_meal_app/data/repositories/abstract/measurement_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/measurement_repository_remote.dart';

class MeasurementRepositoryImpl extends MeasurementRepository {
  final MeasurementRepositoryRemote measurementRepositoryRemote;

  MeasurementRepositoryImpl({required this.measurementRepositoryRemote});

  @override
  Future<List<Measurement>> getMeasurement() {
    return measurementRepositoryRemote.getMeasurement();
  }
}