import 'package:plan_meal_app/data/model/bmi.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/data/model/user_info.dart';
import 'package:plan_meal_app/data/model/user_overview.dart';

abstract class UserRepository {
  Future<String> signIn({required String email, required String password});

  Future<String> signUp({required String email, required String password});

  Future<UserInfo> getUser();

  Future<BMI> getBMI();

  Future<UserOverview> getOverview(String date);

  Future<String> updateWeight(int weight);

  Future<String> updateUserInfo(
      {required int id,
      required String firstName,
      required String lastName,
      required String sex,
      required String dob,
      required int height,
      required int weight,
      required int age,
      required String imageUrl,
      required String healthGoal,
      required int desiredWeight,
      required String activityIntensity,
      required String email});

  Future<String> postUserProfile(User user, String email, String token);

  Future<String> changePassword(String oldPassword, String newPassword);
}
