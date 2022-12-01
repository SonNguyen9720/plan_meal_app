import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/entities/member_entity.dart';
import 'package:plan_meal_app/presentation/features/market/groups/group_detail/bloc/group_detail_bloc.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen(
      {Key? key, required this.groupName, required this.groupId})
      : super(key: key);
  final String groupName;
  final int groupId;
  final coverImageHeight = 180.0;
  final avatarSize = 80.0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocConsumer<GroupDetailBloc, GroupDetailState>(
        listener: (context, state) async {
          if (state is GroupDetailLoading) {
            EasyLoading.show(
              status: "Loading ...",
              maskType: EasyLoadingMaskType.black,
            );
          } else if (state is GroupDetailFinished) {
            if (EasyLoading.isShow) {
              await EasyLoading.dismiss();
            }
          }
        },
        buildWhen: (previousState, state) {
          if (state is GroupDetailLoading || state is GroupDetailFinished) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is GroupDetailHasMember) {
            return Scaffold(
                body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      buildCoverImage(),
                      Positioned(
                          top: coverImageHeight - avatarSize / 2,
                          left: 16,
                          child: buildAvatar()),
                      Positioned(child: buildHeaderButtons(context)),
                    ],
                  ),
                  SizedBox(
                    height: avatarSize / 2 + 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          groupName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        buildMemberFunction(context, state),
                        const SizedBox(
                          height: 16,
                        ),
                        listMemberCard(state.listMember, context, state),
                      ],
                    ),
                  )
                ],
              ),
            ));
          }
          return Container();
        },
      ),
    );
  }

  Widget buildCoverImage() {
    return Image.asset(
      "assets/background_default.jpg",
      height: coverImageHeight,
      fit: BoxFit.fitHeight,
    );
  }

  Widget buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.orangeLight,
        border: Border.all(color: AppColors.white, width: 4.0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/group_default_avatar.png",
            height: avatarSize,
          )),
    );
  }

  Widget buildHeaderButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: 32,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.settings,
              color: AppColors.white,
              size: 32,
            ),
          )
        ],
      ),
    );
  }

  Widget buildMemberFunction(BuildContext context, GroupDetailState state) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.group,
            size: 20,
          ),
        ),
        const Expanded(
            child: Text(
          "Members",
          style: TextStyle(fontSize: 20),
        )),
        GestureDetector(
          onTap: () {
            if (state is GroupDetailHasMember) {
              String id = groupId.toString();
              Navigator.of(context)
                  .pushNamed(PlanMealRoutes.addMember, arguments: id);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.black),
            ),
            child: const Text(
              "+ Add",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget listMemberCard(List<MemberEntity> memberEntityList,
      BuildContext context, GroupDetailHasMember state) {
    return Column(
      children: List.generate(memberEntityList.length, (index) {
        if (state.listMember[index].isAdmin) {
          return Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        memberEntityList[index].name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        memberEntityList[index].email,
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.gray),
                      ),
                    ],
                  ),
                  Text(memberEntityList[index].isAdmin ? "Admin" : "Member"),
                ],
              ),
            ),
          );
        }
        return Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.2,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    BlocProvider.of<GroupDetailBloc>(context).add(
                        GroupDetailRemoveMemberEvent(
                            groupId: groupId,
                            memberId: state.listMember[index].userId,
                            memberList: state.listMember));
                  },
                  backgroundColor: AppColors.red,
                  foregroundColor: AppColors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ]),
          child: Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        memberEntityList[index].name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        memberEntityList[index].email,
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.gray),
                      ),
                    ],
                  ),
                  Text(memberEntityList[index].isAdmin ? "Admin" : "Member"),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
