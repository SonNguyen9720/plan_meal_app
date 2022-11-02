import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_group/bloc/add_group_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({Key? key}) : super(key: key);

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          var size = MediaQuery.of(context).size;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(
                //   flex: 1,
                //   child: Text(
                //     "Group name",
                //     style: GoogleFonts.signika(
                //       fontSize: 32,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    autofocus: true,
                    controller: groupNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: AppColors.green),
                        ),
                        labelText: 'Group name',
                        hintText: 'Good meal group'),
                    style: GoogleFonts.signika(
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: AppColors.green),
                      ),
                      labelText: 'Password',
                    ),
                    style: GoogleFonts.signika(
                      fontSize: 16,
                      height: 1.2,
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.3,
                ),
                NavigateButton(
                    text: "Continue",
                    callbackFunc: () {
                      if (groupNameController.text.isNotEmpty) {
                        _onNavigationButton(
                            groupNameController.text, passwordController.text);
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

  void _onNavigationButton(String groupName, String password) {
    BlocProvider.of<AddGroupBloc>(context)
        .add(NameGroupSubmitEvent(name: groupName, password: password));
  }
}
