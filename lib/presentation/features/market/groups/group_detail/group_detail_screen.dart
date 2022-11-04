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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
        backgroundColor: AppColors.green,
      ),
      body: BlocConsumer<GroupDetailBloc, GroupDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GroupDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GroupDetailHasMember) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Add member"),
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.green,
                          primary: AppColors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Delete group"),
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.red,
                          primary: AppColors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                  ],
                ),
                Expanded(child: listMemberCard(state.listMember)),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Market plan",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      primary: AppColors.white,
                      backgroundColor: AppColors.green,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20)),
                )
              ]),
            );
          }
          return const Text("No state to handle");
        },
      ),
    );
  }

  Widget listMemberCard(List<MemberEntity> memberEntityList) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(memberEntityList.length, (index) {
          return Card(
            color: AppColors.greenPastel,
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
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        memberEntityList[index].email,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Text(memberEntityList[index].isAdmin ? "Admin" : "Member"),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
