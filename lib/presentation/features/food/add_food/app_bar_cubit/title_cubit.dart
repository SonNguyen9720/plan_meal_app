import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'title_state.dart';

class TitleCubit extends Cubit<TitleState> {
  TitleCubit() : super(TitleInitial(title: TitleState.mealTitle[0]));

  void changeTitle(int index) {
    if (index < 0 || index > 2) {
      return;
    } else {
      emit(TitleInitial(title: TitleState.mealTitle[index]));
    }
  }
}
