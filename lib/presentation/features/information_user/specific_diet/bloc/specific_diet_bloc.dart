import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'specific_diet_event.dart';
part 'specific_diet_state.dart';

class SpecificDietBloc extends Bloc<SpecificDietEvent, SpecificDietState> {
  SpecificDietBloc() : super(const SpecificDietInitial("")) {
    on<ChooseSpecificDietEvent>(_onChooseSpecificDietEvent);

    on<SubmitSpecificDietEvent>(_onSubmitSpecificDietEvent);
  }

  void _onChooseSpecificDietEvent(
      ChooseSpecificDietEvent event, Emitter<SpecificDietState> emit) {
    emit(SpecificDietUpdated(event.specificDiet));
  }

  void _onSubmitSpecificDietEvent(
      SubmitSpecificDietEvent event, Emitter<SpecificDietState> emit) {
    // var newUser = event.user.copyWith(dietType: state.specificDiet);
    // emit(SpecificDietSubmitted(state.specificDiet, newUser));
  }
}
