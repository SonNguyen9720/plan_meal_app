import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'user_name_state.dart';

class UserNameCubit extends Cubit<UserNameState> {
  UserNameCubit() : super(UserNameInitial());

  void onNaviagteButtonPressed(String userName) {
    var user = User(name: userName);
    emit(UserNameStoraged(user: user));
  }
}
