import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/domain/entities/food_detail_entity.dart';

part 'food_detail_event.dart';

part 'food_detail_state.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  final FoodRepository foodRepository;

  FoodDetailBloc({required this.foodRepository}) : super(FoodDetailInitial()) {
    on<FoodDetailLoadEvent>(_onFoodDetailLoadEvent);
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
}
