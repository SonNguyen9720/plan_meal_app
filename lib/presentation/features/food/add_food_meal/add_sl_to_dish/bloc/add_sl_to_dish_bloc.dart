import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/shopping_list.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/entities/sl_food_entity.dart';

part 'add_sl_to_dish_event.dart';

part 'add_sl_to_dish_state.dart';

class AddSlToDishBloc extends Bloc<AddSlToDishEvent, AddSlToDishState> {
  final ShoppingListRepository shoppingListRepository;

  AddSlToDishBloc({required this.shoppingListRepository})
      : super(AddSlToDishInitial()) {
    on<AddSlToDishLoadSlEvent>(onAddSlToDishLoadSlEvent);
    on<AddSlToDishSelectEvent>(onAddSlToDishSelectEvent);
    on<AddSlToDishDeselectEvent>(onAddSlToDishDeselectEvent);
  }

  Future<void> onAddSlToDishLoadSlEvent(
      AddSlToDishLoadSlEvent event, Emitter<AddSlToDishState> emit) async {
    emit(AddSlToDishLoading());
    List<ShoppingListModel> slModelList = [];
    List<SlFoodEntity> slEntityList = [];
    var sl = await shoppingListRepository.getShoppingList();
    var slGroup = await shoppingListRepository.getGroupShoppingList();
    slModelList.addAll(sl);
    slModelList.addAll(slGroup);
    for (var element in slModelList) {
      SlFoodEntity slFoodEntity = SlFoodEntity(
          slId: element.shoppingList!.id.toString(),
          name: "Shopping list",
          date: element.date!);
      slEntityList.add(slFoodEntity);
    }
    emit(AddSlToDishLoaded(slList: slEntityList));
  }

  void onAddSlToDishSelectEvent(AddSlToDishSelectEvent event, Emitter<AddSlToDishState> emit) {
    List<SlFoodEntity> slList = [];
    if (state is AddSlToDishLoaded) {
      slList.addAll((state as AddSlToDishLoaded).slList);
    } else {
      slList.addAll((state as AddSlToDishChosen).slList);
    }
    emit(AddSlToDishChosen(index: event.index, slList: slList));
  }

  void onAddSlToDishDeselectEvent(AddSlToDishDeselectEvent event, Emitter<AddSlToDishState> emit) {
    List<SlFoodEntity> slList = [];
    slList.addAll((state as AddSlToDishChosen).slList);
    emit(AddSlToDishLoaded(slList: slList));
  }
}
