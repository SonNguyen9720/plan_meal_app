import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/entities/food_rating_entity.dart';

part 'food_rating_event.dart';

part 'food_rating_state.dart';

class FoodRatingBloc extends Bloc<FoodRatingEvent, FoodRatingState> {
  final UserRepository userRepository;

  FoodRatingBloc({required this.userRepository}) : super(FoodRatingInitial()) {
    on<FoodRatingLoadFood>(_onFoodRatingLoadFood);
    on<FoodRatingLikeFoodEvent>(_onFoodRatingLikeFoodEvent);
    on<FoodRatingDislikedFoodEvent>(_onFoodRatingDislikedFoodEvent);
  }

  Future<void> _onFoodRatingLoadFood(
      FoodRatingLoadFood event, Emitter<FoodRatingState> emit) async {
    emit(FoodRatingLoading());
    var favoriteFoodList = await userRepository.getFavoriteDish();
    var dislikedFoodList = await userRepository.getDisLikedDish();
    List<FoodRatingEntity> favoriteFoodListEntityList = [];
    List<FoodRatingEntity> dislikedFoodListEntityList = [];
    for (var element in favoriteFoodList) {
      var foodRatingEntity = FoodRatingEntity(
          foodId: element.dish!.id.toString(),
          name: element.dish!.name!,
          isLiked: true,
          isSelected: true);
      favoriteFoodListEntityList.add(foodRatingEntity);
    }

    for (var element in dislikedFoodList) {
      var foodRatingEntity = FoodRatingEntity(
          foodId: element.dish!.id.toString(),
          name: element.dish!.name!,
          isLiked: false,
          isSelected: true);
      dislikedFoodListEntityList.add(foodRatingEntity);
    }

    emit(FoodRatingLoaded(
        favoriteFoodList: favoriteFoodListEntityList,
        dislikedFoodList: dislikedFoodListEntityList));
  }

  Future<void> _onFoodRatingLikeFoodEvent(
      FoodRatingLikeFoodEvent event, Emitter<FoodRatingState> emit) async {
    List<FoodRatingEntity> favoriteList = [];
    List<FoodRatingEntity> dislikedList = [];

    favoriteList.addAll((state as FoodRatingLoaded).favoriteFoodList);
    dislikedList.addAll((state as FoodRatingLoaded).dislikedFoodList);

    String result = await userRepository.postFavoriteDish(event.foodRatingEntity.foodId);

    if (event.favoriteIndex != null) {
      favoriteList[event.favoriteIndex!] = event.foodRatingEntity;
    }

    if (event.dislikedIndex != null) {
      dislikedList[event.dislikedIndex!] = event.foodRatingEntity;
    }

    emit(FoodRatingLoaded(
        favoriteFoodList: favoriteList, dislikedFoodList: dislikedList));
  }

  Future<void> _onFoodRatingDislikedFoodEvent(FoodRatingDislikedFoodEvent event, Emitter<FoodRatingState> emit) async {
    List<FoodRatingEntity> favoriteList = [];
    List<FoodRatingEntity> dislikedList = [];

    favoriteList.addAll((state as FoodRatingLoaded).favoriteFoodList);
    dislikedList.addAll((state as FoodRatingLoaded).dislikedFoodList);

    String result = await userRepository.postDislikedDish(event.foodRatingEntity.foodId);

    if (event.favoriteIndex != null) {
      favoriteList[event.favoriteIndex!] = event.foodRatingEntity;
    }

    if (event.dislikedIndex != null) {
      dislikedList[event.dislikedIndex!] = event.foodRatingEntity;
    }

    emit(FoodRatingLoaded(
        favoriteFoodList: favoriteList, dislikedFoodList: dislikedList));
  }
}
