import 'package:plan_meal_app/data/model/bmi.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/data/model/user_info.dart';
import 'package:plan_meal_app/data/model/user_overview.dart';
import 'package:plan_meal_app/data/model/weight.dart';
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

  @override
  Future<BMI> getBMI() {
    return userRepositoryRemote.getBMI();
  }

  @override
  Future<UserOverview> getOverview(String date) {
    return userRepositoryRemote.getOverview(date);
  }

  @override
  Future<String> updateWeight(int weight) {
    return userRepositoryRemote.updateWeight(weight);
  }

  @override
  Future<String> updateUserInfo(
      {required int id,
      required String firstName,
      required String lastName,
      required String sex,
      required String dob,
      required int height,
      required int weight,
      required String imageUrl,
      required String healthGoal,
      required int desiredWeight,
      required String activityIntensity,
      required String email}) {
    return userRepositoryRemote.updateUserInfo(
        id: id,
        firstName: firstName,
        lastName: lastName,
        sex: sex,
        dob: dob,
        height: height,
        weight: weight,
        imageUrl: imageUrl,
        healthGoal: healthGoal,
        desiredWeight: desiredWeight,
        activityIntensity: activityIntensity,
        email: email);
  }

  @override
  Future<String> postUserProfile(User user, String email, String token) {
    return userRepositoryRemote.postUserProfile(user, email, token);
  }

  @override
  Future<String> changePassword(String oldPassword, String newPassword) {
    return userRepositoryRemote.changePassword(oldPassword, newPassword);
  }

  @override
  Future<String> updateUserProfile(
      {required String firstName,
      required String lastName,
      required String sex,
      required String dob,
      required int height,
      required int weight,
      required String imageUrl,
      required String healthGoal,
      required int desiredWeight,
      required String activityIntensity,
      required String token}) {
    return userRepositoryRemote.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
        sex: sex,
        dob: dob,
        height: height,
        weight: weight,
        imageUrl: imageUrl,
        healthGoal: healthGoal,
        desiredWeight: desiredWeight,
        activityIntensity: activityIntensity,
        token: token);
  }

  @override
  Future<List<Weight>> getListWeight(String startDate, String endDate) {
    return userRepositoryRemote.getListWeight(startDate, endDate);
  }
}
