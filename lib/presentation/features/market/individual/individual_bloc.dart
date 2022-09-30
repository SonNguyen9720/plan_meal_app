import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'individual_event.dart';

part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  IndividualBloc() : super(IndividualInitial()) {
    on<IndividualLoadingDataEvent>(_onIndividualLoadingDataEvent);
    on<IndividualChangeDateEvent>(_onIndividualChangeDateEvent);
  }

  Future<void> _onIndividualLoadingDataEvent(
      IndividualLoadingDataEvent event, Emitter<IndividualState> emit) async {
    var dateFormat = DateFormat('dd/MM/yyyy');
    var date = DateTime.now();

    emit(IndividualLoadingItem(dateTime: date));
    await Future.delayed(const Duration(seconds: 2));
    emit(IndividualNoItem(dateTime: dateFormat.format(date)));
  }

  Future<void> _onIndividualChangeDateEvent(
      IndividualChangeDateEvent event, Emitter<IndividualState> emit) async {
    var dateFormat = DateFormat('dd/MM/yyyy');
    var date = event.dateTime;

    emit(IndividualLoadingItem(dateTime: date));
    await Future.delayed(const Duration(seconds: 2));
    emit(IndividualNoItem(dateTime: dateFormat.format(date)));
  }
}
