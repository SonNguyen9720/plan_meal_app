import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(const GenderInitial());

  void onGenderChoosing(bool isFemale) {
    print("$isFemale");
    if (isFemale) {
      emit(const GenderFemaleChosen());
    } else {
      emit(const GenderMaleChosen());
    }
  }

  void onNavigateButtonPressed({required User user}) {
    if (state is GenderFemaleChosen) {
      var newUser = user.copyWith(gender: "female");
      emit(GenderSubmit(newUser));
    } else if (state is GenderMaleChosen) {
      var newUser = user.copyWith(gender: "male");
      emit(GenderSubmit(newUser));
    }
  }
}
