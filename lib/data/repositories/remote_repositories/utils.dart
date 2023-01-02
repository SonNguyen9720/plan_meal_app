import 'package:plan_meal_app/config/storage.dart';

class HttpClient {
  static String firebaseToken =
      "AAAAkXKk_I4:APA91bHAqns6wq3xJzrNtiLCb5xrqABcTrdIXAcdKVysYXphK9FFKKLmls9OU-FxV398ehI7gvah7JUi0S7vvTrFtQ01jYU50oebFpA9T0FmU8Y2bjs4jxAO5Pyb7NK2JYQhF81ZHp06";

  Future<Map<String, String>> createHeader() async {
    var token = await Storage().secureStorage.read(key: 'access_token') ?? '';
    var header = <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + token,
      'Content-Type': 'application/json'
    };
    return header;
  }

  Future<Map<String, String>> createGetHeader() async {
    var token = await Storage().secureStorage.read(key: 'access_token') ?? '';
    var header = <String, String>{
      'Authorization': 'Bearer ' + token,
      'Content-Type': 'application/json'
    };
    return header;
  }

  Future<Map<String, String>> createHeaderWithoutToken() async {
    var header = <String, String>{
      'accept': '*/*',
      'Content-Type': 'application/json'
    };
    return header;
  }

  static String parseToHtmlDate(String date) {
    return date.replaceAll('/', '%2F');
  }
}
