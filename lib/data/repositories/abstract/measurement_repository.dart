import 'package:plan_meal_app/data/model/measurement.dart';

abstract class MeasurementRepository {
  Future<List<Measurement>> getMeasurement();
}