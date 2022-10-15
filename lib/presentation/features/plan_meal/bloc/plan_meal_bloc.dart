import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plan_meal_event.dart';
part 'plan_meal_state.dart';

class PlanMealBloc extends Bloc<PlanMealEvent, PlanMealState> {
  PlanMealBloc() : super(PlanMealInitial()) {
    on<PlanMealEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
