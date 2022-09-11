import 'package:plan_meal_app/data/model/app_user.dart';

abstract class UserRepository {
  Future<String> signIn({required String email, required String password});

  Future<String> signUp({required String email, required String password});

  Future<AppUser> getUser();
}
