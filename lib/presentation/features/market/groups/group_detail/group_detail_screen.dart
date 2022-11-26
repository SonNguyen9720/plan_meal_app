import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
    var size = MediaQuery
        .of(context)
        .size;

    return SafeArea(
      child: BlocConsumer<GroupDetailBloc, GroupDetailState>(
        listener: (context, state) {},
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
                      SizedBox(height: avatarSize / 2 + 20,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(groupName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 16,),
                            buildMemberFunction(),
                            const SizedBox(height: 16,),
                            listMemberCard(state.listMember),
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

  Widget buildMemberFunction() {
    return Row(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.group, size: 20,),
      ),
      const Expanded(child: Text("Members", style: TextStyle(fontSize: 20),)),
      GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.black),
          ),
          child: const Text("+ Add", style: TextStyle(fontSize: 16),),
        ),
      ),
    ],);
  }

  Widget listMemberCard(List<MemberEntity> memberEntityList) {
    return Column(
      children: List.generate(memberEntityList.length, (index) {
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
                      style: const TextStyle(fontSize: 14, color: AppColors.gray),
                    ),
                  ],
                ),
                Text(memberEntityList[index].isAdmin ? "Admin" : "Member"),
              ],
            ),
          ),
        );
      }),
    );
  }
}
