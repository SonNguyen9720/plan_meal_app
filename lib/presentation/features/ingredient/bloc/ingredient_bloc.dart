import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  IngredientBloc() : super(IngredientInitial()) {
    on<IngredientEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
