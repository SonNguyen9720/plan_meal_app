import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'height_state.dart';

class HeightCubit extends Cubit<HeightState> {
  HeightCubit() : super(HeightInitial());

  void onNavigationButtonPressed(int height, User user) {
    var newUser = user.copyWith(height: height);
    emit(HeightStored(newUser));
  }
}
