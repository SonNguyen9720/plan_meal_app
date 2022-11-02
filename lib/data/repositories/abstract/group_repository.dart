abstract class GroupRepository {
  Future<void> createGroup({required String name, required String password});
}