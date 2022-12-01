import 'package:plan_meal_app/data/model/group.dart';
import 'package:plan_meal_app/data/model/group_member.dart';

abstract class GroupRepository {
  Future<void> createGroup({required String name, required String password});

  Future<List<GroupUser>> getGroup();

  Future<List<GroupMember>> getMemberListByGroupId({required int groupId});
  Future<String> addMember(String groupId, String email);
  Future<String> removeMember(String userId, String groupId);
}