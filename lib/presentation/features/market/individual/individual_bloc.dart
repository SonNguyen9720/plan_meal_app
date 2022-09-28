import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'individual_event.dart';
part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  IndividualBloc() : super(IndividualInitial()) {
    on<IndividualEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
