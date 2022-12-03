import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_information_event.dart';
part 'update_information_state.dart';

class UpdateInformationBloc extends Bloc<UpdateInformationEvent, UpdateInformationState> {
  UpdateInformationBloc() : super(UpdateInformationInitial()) {
    on<UpdateInformationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
