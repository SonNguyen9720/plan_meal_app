import 'package:plan_meal_app/data/model/group.dart';

abstract class GroupRepository {
  Future<void> createGroup({required String name, required String password});

  Future<List<GroupUser>> getGroup();
}