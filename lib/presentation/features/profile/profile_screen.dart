import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/user_utils.dart';
import 'package:plan_meal_app/presentation/features/profile/avatar_bloc/bloc/avatar_bloc.dart';
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
                          BlocProvider(
                            create: (context) => AvatarBloc(
                                firebaseFireStoreRepository: RepositoryProvider
                                    .of<FirebaseFireStoreRepository>(context),
                                userRepository:
                                    RepositoryProvider.of<UserRepository>(
                                        context)),
                            child: buildAvatar(context),
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
                      ProfileTileComponent(imageUrl: "", title: "Food exclusion", onPressed: () {}),
                      const SizedBox(
                        height: 24,
                      ),
                      ProfileTileComponent(imageUrl: "", title: "Your food rating", onPressed: () {}),
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
    return BlocConsumer<AvatarBloc, AvatarState>(
      listener: (context, state) async {
        if (state is AvatarWaiting) {
          EasyLoading.show(
            status: "Loading ...",
            maskType: EasyLoadingMaskType.black,
          );
        } else if (state is AvatarFinished) {
          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }
        } else if (state is AvatarError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(state.errorMessage),
                );
              });
        }
      },
      builder: (context, state) {
        if (state is AvatarInitial) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  XFile? pickedFile;
                  await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          "From camera",
                                          style: TextStyle(
                                              color: AppColors.green,
                                              fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          "From gallery",
                                          style: TextStyle(
                                              color: AppColors.green,
                                              fontSize: 20),
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
                      })
                      .whenComplete(() => BlocProvider.of<AvatarBloc>(context)
                      .add(AvatarPickFromCameraEvent(xFile: pickedFile)));
                },
                child: imageUrl.isNotEmpty
                    ? Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    image: DecorationImage(
                      image: NetworkImage(state.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.green, width: 4.0),
                  ),
                )
                    : Container(
                  height: 140,
                  width: 140,
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
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                    child: const Icon(Icons.edit, color: AppColors.white, size: 16,)),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
