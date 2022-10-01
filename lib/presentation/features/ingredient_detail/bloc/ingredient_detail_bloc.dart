import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ingredient_detail_event.dart';
part 'ingredient_detail_state.dart';

class IngredientDetailBloc
    extends Bloc<IngredientDetailEvent, IngredientDetailState> {
  IngredientDetailBloc() : super(IngredientDetailInitial()) {
    on<IngredientDetailLoadEvent>(_onIngredientLoadEvent);
  }

  void _onIngredientLoadEvent(
      IngredientDetailLoadEvent event, Emitter<IngredientDetailState> emit) {
    emit(IngredientDetailLoading());
    emit(IngredientDetailSuccess());
  }
}
