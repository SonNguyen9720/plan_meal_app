import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/global_variable.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/storage.dart';
import 'package:plan_meal_app/domain/entities/user_information_entity.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';

class UserUtils {
  static Future<void> logOut(BuildContext context) async {
    await PreferenceUtils.clear();
    Storage().token = '';
    await Storage().secureStorage.delete(key: 'access_token');
    Navigator.of(context)
        .pushNamedAndRemoveUntil(PlanMealRoutes.onboard, ((Route<dynamic> route) => false));
  }

  static UserInformationEntity getUserInformation() {
    int userId =
        int.parse(PreferenceUtils.getString(GlobalVariable.userId) ?? "0");
    String firstName =
        PreferenceUtils.getString(GlobalVariable.firstName) ?? "";
    String lastName = PreferenceUtils.getString(GlobalVariable.lastName) ?? "";
    String sex = PreferenceUtils.getString(GlobalVariable.sex) ?? "male";
    String dob = PreferenceUtils.getString(GlobalVariable.dob) ??
        DateTime.now().toString();
    int height =
        int.parse(PreferenceUtils.getString(GlobalVariable.height) ?? "0");
    int weight =
        int.parse(PreferenceUtils.getString(GlobalVariable.weight) ?? "0");
    String imageUrl = PreferenceUtils.getString(GlobalVariable.imageUrl) ?? "";
    String healthGoal =
        PreferenceUtils.getString(GlobalVariable.healthGoal) ?? "";
    int desiredWeight =
        int.parse(PreferenceUtils.getString(GlobalVariable.goalWeight) ?? "0");
    String activityIntensity =
        PreferenceUtils.getString(GlobalVariable.activityIntensity) ?? "";
    String email = PreferenceUtils.getString(GlobalVariable.email) ?? "";

    return UserInformationEntity(
      userId: userId,
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
      email: email,
    );
  }
}
