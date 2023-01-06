import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    );
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

  void _onFoodDetailDeselectEvent(
      FoodDetailDeselectEvent event, Emitter<FoodDetailState> emit) {
    
    emit(FoodDetailLoaded(foodDetailEntity: event.foodDetailEntity));
  }
}
