import 'package:plan_meal_app/data/model/group.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/group_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/user_repository_remote.dart';

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

}