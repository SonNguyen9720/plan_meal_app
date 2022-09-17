import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(GenderInitial());

  void onNaviagteButtonPressed({required String gender, required User user}) {
    var newUser = user.copyWith(gender: gender);
    emit(GenderUpdated(newUser));
  }
}
