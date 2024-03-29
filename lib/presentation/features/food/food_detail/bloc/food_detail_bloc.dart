import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/ingredient_of_food.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/entities/food_detail_entity.dart';

part 'food_detail_event.dart';

part 'food_detail_state.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  final FoodRepository foodRepository;
  final UserRepository userRepository;

  FoodDetailBloc({required this.foodRepository, required this.userRepository})
      : super(FoodDetailInitial()) {
    on<FoodDetailLoadEvent>(_onFoodDetailLoadEvent);
    on<FoodDetailLikeEvent>(_onFoodDetailLikeEvent);
    on<FoodDetailDislikeEvent>(_onFoodDetailDislikeEvent);
    on<FoodDetailDeselectEvent>(_onFoodDetailDeselectEvent);
  }

  void _onFoodDetailLoadEvent(
      FoodDetailLoadEvent event, Emitter<FoodDetailState> emit) async {
    emit(FoodDetailLoading());
    var food = await foodRepository.getFood(event.foodId);
    List<IngredientOfFood> ingredientList = await foodRepository.getIngredientByFood(event.foodId);
    List<String> ingredientOfFoodList = [];
    for (var element in ingredientList) {
      ingredientOfFoodList.add(element.ingredient?.name ?? "");
    }
    var foodEntity = FoodDetailEntity(
      foodId: food.id.toString(),
      name: food.name ?? "",
      calories: food.calories.toString(),
      fat: food.fat.toString(),
      protein: food.protein.toString(),
      carb: food.carbohydrates.toString(),
      imageUrl: food.imageUrl ?? "",
      description: food.description ?? "",
      cookingTime: food.cookingTime.toString(),
      recipe: food.recipe.toString(),
      category: food.foodCategory?.name ?? "",
      ingredientList: ingredientOfFoodList,
    );
    var userFoodFavorite = await userRepository.getFavoriteDish();
    var userFoodDisliked = await userRepository.getDisLikedDish();
    for (var element in userFoodFavorite) {
      if (event.foodId == element.dish!.id.toString()) {
        emit(FoodDetailedSelectedState(isLiked: true, foodDetailEntity: foodEntity));
        return;
      }
    }
    for (var element in userFoodDisliked) {
      if (event.foodId == element.dish!.id.toString()) {
        emit(FoodDetailedSelectedState(isLiked: false, foodDetailEntity: foodEntity));
        return;
      }
    }
    emit(FoodDetailLoaded(foodDetailEntity: foodEntity));
  }

  Future<void> _onFoodDetailLikeEvent(
      FoodDetailLikeEvent event, Emitter<FoodDetailState> emit) async {
    String result = await userRepository.postFavoriteDish(event.dishId);
    if (result == "201") {
      emit(FoodDetailedSelectedState(
          isLiked: true, foodDetailEntity: event.foodDetailEntity));
    }
  }

  Future<void> _onFoodDetailDislikeEvent(
      FoodDetailDislikeEvent event, Emitter<FoodDetailState> emit) async {
    String result = await userRepository.postDislikedDish(event.dishId);
    if (result == "201") {
      emit(FoodDetailedSelectedState(
          isLiked: false, foodDetailEntity: event.foodDetailEntity));
    }
  }

  Future<void> _onFoodDetailDeselectEvent(
      FoodDetailDeselectEvent event, Emitter<FoodDetailState> emit) async {
    if (event.isLiked) {
      await userRepository.deleteFavoriteDish(event.dishId);
    } else {
      await userRepository.deleteDislikedDish(event.dishId);
    }
    emit(FoodDetailLoaded(foodDetailEntity: event.foodDetailEntity));
  }
}
