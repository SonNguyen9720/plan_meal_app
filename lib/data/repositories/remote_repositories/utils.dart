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

  Future<Map<String,String>> createGetHeader() async {
    var token = await Storage().secureStorage.read(key: 'access_token') ?? '';
    var header = <String, String>{
      'Authorization' : 'Bearer ' + token,
      'Content-Type' : 'application/json'
    };
    return header;
  }

  Future<Map<String,String>> createHeaderWithoutToken() async {
    var header = <String, String>{
      'accept' : '*/*',
      'Content-Type' : 'application/json'
    };
    return header;
  }

  static String parseToHtmlDate(String date) {
    return date.replaceAll('/', '%2F');
  }
}
