import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/config/storage.dart';

class HttpClient {
  Future<Map<String, String>> createHeader() async {
    var token = await Storage().secureStorage.read(key: 'access_token') ?? '';
    var header = <String, String>{
      'accept' : '*/*',
      'Authorization' : 'Bearer ' + token,
      'Content-Type' : 'application/json'
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
