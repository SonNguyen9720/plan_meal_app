import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/measurement.dart';
import 'package:plan_meal_app/data/repositories/abstract/measurement_repository.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';

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
    List<Measurement> listMeasurement =
        await measurementRepository.getMeasurement();
    List<String> measurement = [];
    for (var element in listMeasurement) {
      measurement.add(element.name!.toLowerCase());
    }
    emit(ModifyIngredientInitial(
        measurement: measurement,
        ingredientDetailEntity: event.ingredientDetailEntity));
  }

  void _onModifyIngredientUpdateDataEvent(ModifyIngredientUpdateDataEvent event,
      Emitter<ModifyIngredientState> emit) {
    var ingredientDetail = event.ingredientDetailEntity.copyWith(
      weight: event.weight,
        quantity: event.quantity,
        measurementType: event.measurement,
        type: event.type);
    List<String> measurementList = [];
    measurementList.addAll(event.measurementList);
    emit(ModifyIngredientInitial(
        measurement: measurementList,
        ingredientDetailEntity: ingredientDetail));
  }
}
