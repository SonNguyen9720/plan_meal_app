import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
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
      ),
      body: BlocConsumer<GroupDetailBloc, GroupDetailState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state is GroupDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GroupDetailHasMember) {
            return Column(
              children: List.generate(state.listMember.length, (index) {
                return Text(state.listMember[index].name);
              })
            );
          }
          return const Text("No state to handle");
        },
      ),
    );
  }
}
