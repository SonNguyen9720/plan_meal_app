import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'individual_event.dart';
part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  IndividualBloc() : super(IndividualInitial()) {
    on<IndividualLoadingDataEvent>(_onIndividualLoadingDataEvent);
  }

  void _onIndividualLoadingDataEvent(
      IndividualLoadingDataEvent event, Emitter<IndividualState> emit) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final date = DateTime.now();

    emit(IndividualLoadingItem(dateTime: date));
    emit(IndividualNoItem(dateTime: dateFormat.format(date)));
  }
}
