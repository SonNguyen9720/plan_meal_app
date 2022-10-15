import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/market/groups/group_detail/bloc/group_detail_bloc.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({Key? key, required this.groupName})
      : super(key: key);
  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: BlocBuilder<GroupDetailBloc, GroupDetailState>(
        builder: (context, state) {
          if (state is GroupDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GroupDetailNoMember) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.people_alt_outlined,
                  size: 200,
                  color: AppColors.green,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have member. ",
                          style: GoogleFonts.signika(
                            fontSize: 20,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PlanMealRoutes.addMember);
                        },
                        child: Text(
                          "Add member",
                          style: GoogleFonts.signika(
                            fontSize: 20,
                            color: AppColors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (state is GroupDetailHasMember) {
            return Container();
          }
          return const Text("No state to handle");
        },
      ),
    );
  }
}
