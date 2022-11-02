import 'dart:convert';

import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:http/http.dart' as http;

import '../ultis.dart';

class GroupRepositoryRemote extends GroupRepository {
  @override
  Future<void> createGroup(
      {required String name, required String password}) async {
    var header = HttpClient().createHeader();
    var route =
        Uri.parse(ServerAddresses.serverAddress + ServerAddresses.createGroup);
    var data = <String, String>{
      "name": name,
      "password": password,
      "imageUrl": ""
    };
    var body = json.encode(data);
    var response = await http.post(route, headers: header, body: body);
    Map jsonResponse = json.decode(response.body);
    if (response.statusCode != 201) {
      throw jsonResponse['message'];
    }
  }
}
