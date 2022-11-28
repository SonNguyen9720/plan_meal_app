import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/measurement.dart';
import 'package:plan_meal_app/data/repositories/abstract/measurement_repository.dart';

class MeasurementRepositoryRemote extends MeasurementRepository {
  @override
  Future<List<Measurement>> getMeasurement() async {
    Dio dio = Dio();
    var header = {'accept': 'application/json'};
    String route = ServerAddresses.serverAddress + ServerAddresses.measurement;
    final response = await dio.get(route, options: Options(headers: header));
    Map jsonResponse = response.data;
    if (response.statusCode == 200) {
      List<Measurement> measurementList = [];
      var data = jsonResponse['data'] as List;
      for (var element in data) {
        var measurement = Measurement.fromJson(element);
        measurementList.add(measurement);
      }
      return measurementList;
    } else {
      throw response.statusCode.toString();
    }
  }
}