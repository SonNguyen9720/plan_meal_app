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
