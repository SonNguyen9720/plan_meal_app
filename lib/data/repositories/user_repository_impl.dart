import 'package:plan_meal_app/data/model/user_info.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/user_repository_remote.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRepositoryRemote userRepositoryRemote;

  UserRepositoryImpl({required this.userRepositoryRemote});

  @override
  Future<UserInfo> getUser() {
    return userRepositoryRemote.getUser();
  }

  @override
  Future<String> signIn(
      {required String email, required String password}) async {
    return userRepositoryRemote.signIn(email: email, password: password);
  }

  @override
  Future<String> signUp(
      {required String email, required String password}) async {
    return await userRepositoryRemote.signUp(email: email, password: password);
  }
}
