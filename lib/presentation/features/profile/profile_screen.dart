import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/user_utils.dart';
import 'package:plan_meal_app/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/profile_tile_component.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlanMealAppScaffold(
        bottomMenuIndex: 4,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              return Container(
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
                          buildAvatar(context),
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
                          imageUrl: "assets/profile/group.svg",
                          title: "Manage group",
                          onPressed: () async {
                            var prefs = await SharedPreferences.getInstance();
                            var groupId = prefs.getString("groupId");
                            var groupName = prefs.getString("groupName");
                            if (groupId == null || groupId.isEmpty) {
                              Navigator.of(context)
                                  .pushNamed(PlanMealRoutes.addGroup);
                            } else {
                              var args = {
                                'groupName': groupName,
                                'groupId': int.parse(groupId),
                              };
                              Navigator.of(context).pushNamed(
                                  PlanMealRoutes.groupDetail,
                                  arguments: args);
                            }
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      ProfileTileComponent(
                          imageUrl: "assets/profile/information_icon.svg",
                          title: "Update information",
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(PlanMealRoutes.updateInfo);
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      ProfileTileComponent(
                          imageUrl: "assets/profile/objective.svg",
                          title: "Update goal",
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(PlanMealRoutes.updateGoal);
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      ProfileTileComponent(
                          imageUrl: "assets/profile/lock.svg",
                          title: "Change password",
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(PlanMealRoutes.changePassword);
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      buildLogoutButton(context),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UserUtils.logOut(context);
      },
      child: Container(
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
      ),
    );
  }

  Future<String> getName() async {
    var prefs = await SharedPreferences.getInstance();
    var name = prefs.getString("groupId") ?? "";
    return name;
  }

  Widget buildAvatar(BuildContext context) {
    var imageUrl = PreferenceUtils.getString("imageUrl") ?? "";
    if (imageUrl.isEmpty) {
      return Container(
        height: 64,
        width: 64,
        decoration: const BoxDecoration(
          color: AppColors.lightGray,
          shape: BoxShape.circle,
        ),
        child: const Center(
            child: Icon(
          Icons.person,
          size: 48,
          color: AppColors.white,
        )),
      );
    }
    return GestureDetector(
      onTap: () {
        showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "From camera",
                                style: TextStyle(
                                    color: AppColors.green, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "From gallery",
                                style: TextStyle(
                                    color: AppColors.green, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      },
      child: CircleAvatar(
        backgroundColor: AppColors.green,
        radius: 48,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(64),
              child: Image.network(imageUrl)),
        ),
      ),
    );
  }
}
