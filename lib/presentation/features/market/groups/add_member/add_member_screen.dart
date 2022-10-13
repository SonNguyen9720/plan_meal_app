import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_member/bloc/add_member_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/input_member.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add member"),
      ),
      body: BlocListener<AddMemberBloc, AddMemberState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Column(
          children: [
            Text(
              "Input email to invite member into group.",
              style: GoogleFonts.signika(fontSize: 16),
            ),
            InputMember(textEditingController: textEditingController),
          ],
        ),
      ),
    );
  }
}
