import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/domain/entities/food_meal_entity.dart';

part 'plan_meal_group_event.dart';
part 'plan_meal_group_state.dart';

class PlanMealGroupBloc extends Bloc<PlanMealGroupEvent, PlanMealGroupState> {
  PlanMealGroupBloc() : super(PlanMealGroupInitial(DateTime.now())) {
    on<PlanMealGroupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
