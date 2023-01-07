import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:plan_meal_app/data/repositories/abstract/measurement_repository.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';
import 'package:plan_meal_app/domain/entities/location_entity.dart';
import '../../../../../data/local/measurement_list.dart';
import '../../../../../data/model/measurement_model.dart';

part 'modify_ingredient_event.dart';

part 'modify_ingredient_state.dart';

class ModifyIngredientBloc
    extends Bloc<ModifyIngredientEvent, ModifyIngredientState> {
  final MeasurementRepository measurementRepository;

  ModifyIngredientBloc({required this.measurementRepository})
      : super(ModifyIngredientLoading()) {
    on<ModifyIngredientLoadDataEvent>(_onModifyIngredientLoadDataEvent);
    on<ModifyIngredientUpdateDataEvent>(_onModifyIngredientUpdateDataEvent);
  }

  Future<void> _onModifyIngredientLoadDataEvent(
      ModifyIngredientLoadDataEvent event,
      Emitter<ModifyIngredientState> emit) async {
    emit(ModifyIngredientInitial(
        measurement: measurementList,
        ingredientDetailEntity: event.ingredientDetailEntity));
  }

  void _onModifyIngredientUpdateDataEvent(ModifyIngredientUpdateDataEvent event,
      Emitter<ModifyIngredientState> emit) {
    var ingredientDetail = event.ingredientDetailEntity.copyWith(
      quantity: event.quantity,
      measurementType: event.measurement,
      type: event.type,
      location: event.location,
      note: event.note,
    );
    if (kDebugMode) {
      print(
          "Location: ${ingredientDetail.location} / Note: ${ingredientDetail.note}");
    }
    emit(ModifyIngredientInitial(
        measurement: measurementList,
        ingredientDetailEntity: ingredientDetail));
  }
}
