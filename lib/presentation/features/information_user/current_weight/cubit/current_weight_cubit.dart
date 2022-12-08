import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'current_weight_state.dart';

class CurrentWeightCubit extends Cubit<CurrentWeightState> {
  CurrentWeightCubit() : super(CurrentWeightInitial());

  void onNavigateButtonPressed(int currentWeight, User user) {
    var newUser = user.copyWith(currentWeight: currentWeight);
    emit(CurrentWeightStoraged(user: newUser));
    emit(CurrentWeightInitial());
  }
}
