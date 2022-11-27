import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:plan_meal_app/domain/entities/ingredient_by_day_entity.dart';

part 'individual_event.dart';

part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  IndividualBloc() : super(IndividualInitial()) {
    on<IndividualLoadingDataEvent>(_onIndividualLoadingDataEvent);
    on<IndividualChangeDateEvent>(_onIndividualChangeDateEvent);
  }

  Future<void> _onIndividualLoadingDataEvent(
      IndividualLoadingDataEvent event, Emitter<IndividualState> emit) async {

    emit(IndividualLoadingItem(dateTime: event.dateTime));
    await Future.delayed(const Duration(seconds: 2));
    emit(IndividualNoItem(dateTime: event.dateTime));
  }

  Future<void> _onIndividualChangeDateEvent(
      IndividualChangeDateEvent event, Emitter<IndividualState> emit) async {
    var date = event.dateTime;

    emit(IndividualLoadingItem(dateTime: date));
    await Future.delayed(const Duration(seconds: 2));
    emit(IndividualNoItem(dateTime: date));
  }
}
