import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/presentation/features/profile/update_infomation/bloc/update_information_bloc.dart';

class UpdateInformationScreen extends StatefulWidget {
  const UpdateInformationScreen({Key? key}) : super(key: key);

  @override
  State<UpdateInformationScreen> createState() =>
      _UpdateInformationScreenState();
}

class _UpdateInformationScreenState extends State<UpdateInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update information"),
      ),
      body: BlocConsumer<UpdateInformationBloc, UpdateInformationState>(
        listener: (context, state) {
        },
        buildWhen: (previousState, state) {
          if (state is UpdateInformationWaiting || state is UpdateInformationFinished) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          return Column();
        },
      ),
    );
  }
}
