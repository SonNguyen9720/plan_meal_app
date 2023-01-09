import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/bmi.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiMemberBloc extends Bloc<BmiMemberEvent, BmiMemberState> {
  final UserRepository userRepository;

  BmiMemberBloc({required this.userRepository}) : super(BmiLoading()) {
    on<BmiLoadEvent>((event, emit) async {
      emit(BmiLoading());
      BMI bmi = await userRepository.getMemberBMI(event.member);
      String userBMI = bmi.currentBMI?.toStringAsFixed(2) ?? "0";
      String type = bmi.type ?? "";
      emit(BmiInitial(bmi: userBMI, type: type));
    });
  }
}
