
import 'package:plan_meal_app/data/model/bmi.dart';
import 'package:plan_meal_app/data/model/user_info.dart';

abstract class UserRepository {
  Future<String> signIn({required String email, required String password});

  Future<String> signUp({required String email, required String password});

  Future<UserInfo> getUser();

  Future<BMI> getBMI();
}
