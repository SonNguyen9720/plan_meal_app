import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/group_repository_remote.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/presentation/widgets/independent/profile_tile_component.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GroupRepositoryRemote groupRepositoryRemote = GroupRepositoryRemote();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlanMealAppScaffold(
        bottomMenuIndex: 4,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 128,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: AppColors.lightGray,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.person,
                        size: 64,
                        color: AppColors.white,
                      )),
                    ),
                  ],
                ),
                Text(
                  PreferenceUtils.getString("name") ?? "",
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 24,
                ),
                ProfileTileComponent(
                    imageUrl: "assets/profile/group_icon.svg",
                    title: "Manage group",
                    onPressed: () async {
                      var prefs = await SharedPreferences.getInstance();
                      var groupId = prefs.getString("groupId");
                      var groupName = prefs.getString("groupName");
                      if (groupId!.isNotEmpty) {
                        var args = {
                          'groupName': groupName,
                          'groupId': int.parse(groupId),
                        };
                        Navigator.of(context).pushNamed(PlanMealRoutes.groupDetail, arguments: args);
                      } else {
                        Navigator.of(context).pushNamed(PlanMealRoutes.addGroup);
                      }
                    }),
                const SizedBox(
                  height: 24,
                ),
                ProfileTileComponent(
                    imageUrl: "assets/profile/information_icon.svg",
                    title: "Update information",
                    onPressed: () {}),
                const SizedBox(
                  height: 24,
                ),
                ProfileTileComponent(
                    imageUrl: "assets/profile/goal_icon.svg",
                    title: "Update goal",
                    onPressed: () {
                      Navigator.of(context).pushNamed(PlanMealRoutes.updateGoal);
                    }),
                const SizedBox(
                  height: 24,
                ),
                ProfileTileComponent(
                    imageUrl: "assets/profile/password_icon.svg",
                    title: "Change password",
                    onPressed: () {}),
                const SizedBox(
                  height: 24,
                ),
                buildLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogoutButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Log out",
            style: TextStyle(color: AppColors.red, fontSize: 20),
          ),
          SizedBox(
            width: 8,
          ),
          Icon(
            Icons.logout,
            color: AppColors.red,
            size: 20,
          )
        ],
      ),
    );
  }

  Future<String> getName() async {
    var prefs = await SharedPreferences.getInstance();
    var name = prefs.getString("groupId") ?? "";
    return name;
  }
}
