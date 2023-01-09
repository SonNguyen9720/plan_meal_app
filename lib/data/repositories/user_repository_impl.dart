import 'package:plan_meal_app/data/model/allergic_ingredient.dart';
import 'package:plan_meal_app/data/model/bmi.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/data/model/user_food.dart';
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
      {required String email,
      required String password,
      required String deviceToken}) async {
    return userRepositoryRemote.signIn(
        email: email, password: password, deviceToken: deviceToken);
  }

  @override
  Future<String> signUp(
      {required String email, required String password, required String deviceToken}) async {
    return await userRepositoryRemote.signUp(email: email, password: password, deviceToken: deviceToken);
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

  @override
  Future<String> testPushNotification(String title, String body) {
    return userRepositoryRemote.testPushNotification(title, body);
  }

  @override
  Future<String> postAllergicIngredient(List<String> ingredientIdList, [String token = ""]) {
    return userRepositoryRemote.postAllergicIngredient(ingredientIdList, token);
  }

  @override
  Future<String> postFavoriteDish(String dishId) {
    return userRepositoryRemote.postFavoriteDish(dishId);
  }

  @override
  Future<String> postDislikedDish(String dishId) {
    return userRepositoryRemote.postDislikedDish(dishId);
  }

  @override
  Future<String> deleteDislikedDish(String dishId) {
    return userRepositoryRemote.deleteDislikedDish(dishId);
  }

  @override
  Future<String> deleteFavoriteDish(String dishId) {
    return userRepositoryRemote.deleteFavoriteDish(dishId);
  }

  @override
  Future<List<UserFood>> getDisLikedDish() {
    return userRepositoryRemote.getDisLikedDish();
  }

  @override
  Future<List<UserFood>> getFavoriteDish() {
    return userRepositoryRemote.getFavoriteDish();
  }

  @override
  Future<List<AllergicIngredient>> getAllergicIngredient() {
    return userRepositoryRemote.getAllergicIngredient();
  }

  @override
  Future<String> deleteAllergicIngredient(String ingredientId) {
    return userRepositoryRemote.deleteAllergicIngredient(ingredientId);
  }

  @override
  Future<List<Weight>> getListWeightMember(String startDate, String endDate, String memberId) {
    return userRepositoryRemote.getListWeightMember(startDate, endDate, memberId);
  }

  @override
  Future<BMI> getMemberBMI(String memberId) {
    return userRepositoryRemote.getMemberBMI(memberId);
  }

  @override
  Future<UserOverview> getOverviewMember(String date, String memberId) {
    return userRepositoryRemote.getOverviewMember(date, memberId);
  }

  @override
  Future<UserInfo> getUserMember(String memberId) {
    return userRepositoryRemote.getUserMember(memberId);
  }
}
