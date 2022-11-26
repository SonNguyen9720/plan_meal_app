import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/group_repository_remote.dart';
import 'package:plan_meal_app/presentation/widgets/independent/profile_tile_component.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class ProfileScreen extends StatelessWidget {
  final GroupRepositoryRemote groupRepositoryRemote = GroupRepositoryRemote();

  ProfileScreen({Key? key}) : super(key: key);

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
                  "Son Nguyen",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 24,
                ),
                ProfileTileComponent(
                    imageUrl: "assets/profile/group_icon.svg",
                    title: "Manage group",
                    onPressed: () async {
                      var groupList = await groupRepositoryRemote.getGroup();
                      if (groupList.isNotEmpty) {
                        var args = {
                          'groupName': groupList.first.group?.name,
                          'groupId': groupList.first.group?.id,
                        };
                        Navigator.of(context).pushNamed(PlanMealRoutes.groupDetail, arguments: args);
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
                    onPressed: () {}),
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
}
