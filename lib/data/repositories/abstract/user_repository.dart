import 'package:plan_meal_app/data/model/allergic_ingredient.dart';
import 'package:plan_meal_app/data/model/bmi.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/data/model/user_food.dart';
import 'package:plan_meal_app/data/model/user_info.dart';
import 'package:plan_meal_app/data/model/user_overview.dart';
import 'package:plan_meal_app/data/model/weight.dart';

abstract class UserRepository {
  Future<String> signIn(
      {required String email,
      required String password,
      required String deviceToken});

  Future<String> signUp({required String email, required String password, required String deviceToken});

  Future<UserInfo> getUser();
  Future<UserInfo> getUserMember(String memberId);

  Future<BMI> getBMI();
  Future<BMI> getMemberBMI(String memberId);

  Future<UserOverview> getOverview(String date);
  Future<UserOverview> getOverviewMember(String date, String memberId);

  Future<String> updateWeight(int weight);

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
      required String email});

  Future<String> postUserProfile(User user, String email, String token);

  Future<String> changePassword(String oldPassword, String newPassword);

  Future<String> updateUserProfile({
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
    required String token,
  });

  Future<List<Weight>> getListWeight(String startDate, String endDate);
  Future<List<Weight>> getListWeightMember(String startDate, String endDate, String memberId);

  Future<String> testPushNotification(String title, String body);
  Future<String> postAllergicIngredient(List<String> ingredientIdList, [String token]);
  Future<List<AllergicIngredient>> getAllergicIngredient();
  Future<String> deleteAllergicIngredient(String ingredientId);
  Future<String> postFavoriteDish(String dishId);
  Future<String> postDislikedDish(String dishId);
  Future<String> deleteFavoriteDish(String dishId);
  Future<String> deleteDislikedDish(String dishId);
  Future<List<UserFood>> getFavoriteDish();
  Future<List<UserFood>> getDisLikedDish();
}
