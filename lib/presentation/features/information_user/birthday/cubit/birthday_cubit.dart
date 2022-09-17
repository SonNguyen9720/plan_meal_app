import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:intl/intl.dart';

part 'birthday_state.dart';

class BirthdayCubit extends Cubit<BirthdayState> {
  BirthdayCubit() : super(BirthdayInitial());

  void onNavigateButtonPressed(String birthdayParam, User user) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    try {
      var birthday = inputFormat.parse(birthdayParam);
      var newUser = user.copyWith(birthday: birthday);
      emit(BirthdayStoraged(newUser));
    } catch (e) {
      emit(BirthdayError(e.toString()));
    }
  }
}
