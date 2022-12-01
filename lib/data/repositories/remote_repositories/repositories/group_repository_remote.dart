import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/group.dart';
import 'package:plan_meal_app/data/model/group_member.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

class GroupRepositoryRemote extends GroupRepository {
  @override
  Future<void> createGroup(
      {required String name, required String password}) async {
    var header = await HttpClient().createHeader();

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

  @override
  Future<List<GroupUser>> getGroup() async {
    var header = await HttpClient().createHeader();
    var route =
        Uri.parse(ServerAddresses.serverAddress + ServerAddresses.getGroup);
    var response = await http.get(route, headers: header);
    Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      List<GroupUser> groupUserList = [];
      var data = jsonResponse["data"] as List;
      for (var element in data) {
        var groupUser = GroupUser.fromJson(element);
        groupUserList.add(groupUser);
      }
      return groupUserList;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw jsonResponse['message'];
    }
  }

  @override
  Future<List<GroupMember>> getMemberListByGroupId(
      {required int groupId}) async {
    var header = await HttpClient().createHeader();
    var route = Uri.parse(ServerAddresses.serverAddress +
        ServerAddresses.getMembersInGroup(groupId));

    var response = await http.get(route, headers: header);
    Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      List<GroupMember> groupMemberList = [];
      var data = jsonResponse["data"] as List;
      for (var element in data) {
        var member = GroupMember.fromJson(element);
        groupMemberList.add(member);
      }
      return groupMemberList;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw jsonResponse['message'];
    }
  }

  @override
  Future<String> addMember(String groupId, String email) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route = ServerAddresses.serverAddress + ServerAddresses.addMember;
    Map bodyData = {
      "email": email,
      "groupId": groupId
    };

    var response = await dio.post(route, data: bodyData, options: Options(
      headers: header
    ));
    return response.statusCode.toString();
  }
}
