import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/config/storage.dart';

class HttpClient {
  Map createHeader() {
    var header = <String, String>{
      'authorization': 'Bearer ' + Storage().token,
    };
    return header;
  }

  Uri createUri(String route, [Map<String, String> param = const {}]) {
    return Uri(
      scheme: 'https',
      host: ServerAddresses.serverAddress,
      path: route,
      queryParameters: param,
    );
  }
}
