import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/domain/validator.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_member/bloc/add_member_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/failed_dialog.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';
import 'package:plan_meal_app/presentation/widgets/independent/success_dialog.dart';

class AddMemberScreen extends StatefulWidget {
  final String groupId;
  const AddMemberScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add member"),
      ),
      body: BlocListener<AddMemberBloc, AddMemberState>(
        listener: (context, state) {
          if (state is AddMemberSuccess) {
            showDialog(
                context: context,
                builder: (context) {
                  return const SuccessDialog();
                });
          } else if (state is AddMemberFailed) {
            showDialog(
                context: context,
                builder: (context) {
                  return const FailedDialog();
                });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Input email to invite member into group.",
                  style: GoogleFonts.signika(fontSize: 24),
                ),
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "email",
                  ),
                  validator: (value) => Validator.checkEmail(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: NavigateButton(
                    text: "Invite",
                    callbackFunc: () {
                      validateAndSend(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateAndSend(BuildContext context) {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      BlocProvider.of<AddMemberBloc>(context).add(SendInvitationToMemberEvent());
    }
  }
}
