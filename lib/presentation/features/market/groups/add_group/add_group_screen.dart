import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_group/bloc/add_group_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({Key? key}) : super(key: key);

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create group"),
      ),
      body: BlocConsumer<AddGroupBloc, AddGroupState>(
        listener: (context, state) {
          if (state is AddGroupSubmitted) {
            print("Navigate to other screen");
            Navigator.of(context).pushNamed(PlanMealRoutes.groupDetail,
                arguments: state.groupName);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Group name",
                    style: GoogleFonts.signika(
                      fontSize: 32,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    autofocus: true,
                    controller: groupNameController,
                    style: GoogleFonts.signika(
                      fontSize: 40,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                NavigateButton(
                    text: "Continue",
                    callbackFunc: () {
                      if (groupNameController.text.isNotEmpty) {
                        _onNavigationButton(groupNameController.text);
                      }
                    })
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  void _onNavigationButton(String groupName) {
    BlocProvider.of<AddGroupBloc>(context)
        .add(NameGroupSubmitEvent(name: groupName));
  }
}
