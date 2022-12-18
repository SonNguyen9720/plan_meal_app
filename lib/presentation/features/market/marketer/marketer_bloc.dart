import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/shopping_list_detail.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';

part 'marketer_event.dart';

part 'marketer_state.dart';

class MarketerBloc extends Bloc<MarketerEvent, MarketerState> {
  final ShoppingListRepository shoppingListRepository;

  MarketerBloc({required this.shoppingListRepository})
      : super(MarketerLoading()) {
    on<MarketerLoadEvent>(_onMarketerLoadEvent);
    on<MarketerAssignEvent>(_onMarketerAssignEvent);
    on<MarketerUnassignEvent>(_onMarketerUnassignEvent);
  }

  void _onMarketerLoadEvent(
      MarketerLoadEvent event, Emitter<MarketerState> emit) async {
    String date = DateTimeUtils.parseDateTime(event.date);
    ShoppingListDetail? shoppingListDetail =
        await shoppingListRepository.getShoppingListDetail(date, event.groupId);
    String userId = PreferenceUtils.getString("userId") ?? "";
    if (shoppingListDetail == null) {
      emit(const MarketerErrorState(
          error: "There is something error, please try again"));
      emit(MarketerLoading());
      return;
    }
    if (shoppingListDetail.marketer == null || userId.isEmpty) {
      emit(const MarketerReady());
      return;
    }
    if (shoppingListDetail.marketer!.id.toString() == userId) {
      var name = shoppingListDetail.marketer!.account!.firstName! +
          " " +
          shoppingListDetail.marketer!.account!.lastName!;
      emit(MarketerReady(marketer: name, isMarketer: true, isReady: true));
    } else {
      var name = shoppingListDetail.marketer!.account!.firstName! +
          " " +
          shoppingListDetail.marketer!.account!.lastName!;
      emit(MarketerReady(marketer: name, isMarketer: false, isReady: true));
    }
  }

  void _onMarketerAssignEvent(
      MarketerAssignEvent event, Emitter<MarketerState> emit) async {
    emit(MarketerWaitingState());
    String date = DateTimeUtils.parseDateTime(event.date);
    String response =
        await shoppingListRepository.assignMarket(date, event.groupId);
    String name = PreferenceUtils.getString("firstName")! +
        " " +
        PreferenceUtils.getString("lastName")!;
    emit(MarketerFinishedState());
    if (response == "201") {
      emit(MarketerReady(marketer: name, isReady: true, isMarketer: true));
      return;
    }
    emit(const MarketerReady());
  }

  void _onMarketerUnassignEvent(
      MarketerUnassignEvent event, Emitter<MarketerState> emit) async {
    emit(MarketerWaitingState());
    String date = DateTimeUtils.parseDateTime(event.date);
    String response =
        await shoppingListRepository.unAssignMarket(date, event.groupId);
    String name = PreferenceUtils.getString("firstName")! +
        " " +
        PreferenceUtils.getString("lastName")!;
    emit(MarketerFinishedState());
    if (response == "201") {
      emit(const MarketerReady());
      return;
    }
    emit(MarketerReady(marketer: name, isReady: true, isMarketer: true));
  }
}
