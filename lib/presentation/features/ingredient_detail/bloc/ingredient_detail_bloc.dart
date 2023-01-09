import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/incompatable_ingredient.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/domain/entities/incompatiable_ingredient_entity.dart';

part 'ingredient_detail_event.dart';

part 'ingredient_detail_state.dart';

class IngredientDetailBloc
    extends Bloc<IngredientDetailEvent, IngredientDetailState> {
  final FoodRepository foodRepository;

  IngredientDetailBloc({required this.foodRepository})
      : super(IngredientDetailInitial()) {
    on<IngredientDetailLoadEvent>(_onIngredientLoadEvent);
  }

  Future<void> _onIngredientLoadEvent(IngredientDetailLoadEvent event,
      Emitter<IngredientDetailState> emit) async {
    emit(IngredientDetailLoading());
    List<IncompatibleIngredient> ingredientList =
        await foodRepository.getIncompatibleIngredient(event.ingredientId);
    List<IncompatiableIngredientEntity> ingredientListEntity = [];
    for (var element in ingredientList) {
      var entity = IncompatiableIngredientEntity(
          name: element.isIncompatibleBy?.name ?? "", note: element.note ?? "");
      ingredientListEntity.add(entity);
    }
    emit(IngredientDetailSuccess(ingredientList: ingredientListEntity));
  }
}
