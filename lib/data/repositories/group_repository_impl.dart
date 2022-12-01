import 'package:plan_meal_app/data/model/group.dart';
import 'package:plan_meal_app/data/model/group_member.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/group_repository_remote.dart';

class GroupRepositoryImpl extends GroupRepository {
  final GroupRepositoryRemote groupRepositoryRemote;

  GroupRepositoryImpl({required this.groupRepositoryRemote});

  @override
  Future<void> createGroup({required String name, required String password}) {
    return groupRepositoryRemote.createGroup(name: name, password: password);
  }

  @override
  Future<List<GroupUser>> getGroup() {
    return groupRepositoryRemote.getGroup();
  }

  @override
  Future<List<GroupMember>> getMemberListByGroupId({required int groupId}) {
    return groupRepositoryRemote.getMemberListByGroupId(groupId: groupId);
  }

  @override
  Future<String> addMember(String groupId, String email) {
    return groupRepositoryRemote.addMember(groupId, email);
  }

  @override
  Future<String> removeMember(String userId, String groupId) {
    return groupRepositoryRemote.removeMember(userId, groupId);
  }

}