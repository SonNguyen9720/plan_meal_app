import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/measurement.dart';
import 'package:plan_meal_app/data/repositories/abstract/measurement_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';

part 'update_ingredient_event.dart';

part 'update_ingredient_state.dart';

class UpdateIngredientBloc
    extends Bloc<UpdateIngredientEvent, UpdateIngredientState> {
  final MeasurementRepository measurementRepository;
  final ShoppingListRepository shoppingListRepository;

  UpdateIngredientBloc(
      {required this.measurementRepository,
      required this.shoppingListRepository})
      : super(UpdateIngredientLoading()) {
    on<UpdateIngredientLoadDataEvent>(_onUpdateIngredientLoadDataEvent);
    on<UpdateIngredientUpdateDataEvent>(_onUpdateIngredientUpdateDataEvent);
    on<UpdateIngredientSendDataEvent>(_onUpdateIngredientSendDataEvent);
  }

  Future<void> _onUpdateIngredientLoadDataEvent(
      UpdateIngredientLoadDataEvent event,
      Emitter<UpdateIngredientState> emit) async {
    List<Measurement> listMeasurement =
        await measurementRepository.getMeasurement();
    List<String> measurement = [];
    for (var element in listMeasurement) {
      measurement.add(element.name!.toLowerCase());
    }
    emit(UpdateIngredientInitial(
        measurement: measurement,
        ingredientDetailEntity: event.ingredientDetailEntity));
  }

  void _onUpdateIngredientUpdateDataEvent(UpdateIngredientUpdateDataEvent event,
      Emitter<UpdateIngredientState> emit) {
    var ingredientDetail = event.ingredientDetailEntity.copyWith(
        quantity: event.quantity,
        weight: event.weight,
        measurementType: event.measurement,
        type: event.type);
    List<String> measurementList = [];
    measurementList.addAll(event.measurementList);
    emit(UpdateIngredientInitial(
        measurement: measurementList,
        ingredientDetailEntity: ingredientDetail));
  }

  Future<void> _onUpdateIngredientSendDataEvent(
      UpdateIngredientSendDataEvent event,
      Emitter<UpdateIngredientState> emit) async {
    emit(UpdateIngredientWaiting());
    String result = await shoppingListRepository.updateIngredient(
        event.ingredientId, event.quantity!, event.weight!, event.measurement!);
    emit(UpdateIngredientFinished());
  }
}
