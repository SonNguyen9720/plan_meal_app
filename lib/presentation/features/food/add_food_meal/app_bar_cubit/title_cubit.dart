import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/local/meal_list.dart';
import 'package:plan_meal_app/data/model/meal_model.dart';

part 'title_state.dart';

class TitleCubit extends Cubit<TitleState> {
  TitleCubit() : super(TitleInitial(meal: mealList.first));

  void changeTitle(int index) {
    if (index < 0 || index > mealList.length - 1) {
      return;
    } else {
      emit(TitleInitial(meal: mealList[index]));
    }
  }
}
