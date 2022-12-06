import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/shopping_list_detail.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/string_utils.dart';

part 'marketer_event.dart';

part 'marketer_state.dart';

class MarketerBloc extends Bloc<MarketerEvent, MarketerState> {
  final ShoppingListRepository shoppingListRepository;

  MarketerBloc({required this.shoppingListRepository})
      : super(MarketerLoading()) {
    on<MarketerLoadEvent>(_onMarketerLoadEvent);
  }

  void _onMarketerLoadEvent(
      MarketerLoadEvent event, Emitter<MarketerState> emit) async {
    String date = DateTimeUtils.parseDateTime(event.date);
    ShoppingListDetail? shoppingListDetail = await shoppingListRepository
        .getShoppingListDetail(date, event.groupId);
    String userId = PreferenceUtils.getString("userId") ?? "";
    if (shoppingListDetail == null) {
      emit(const MarketerErrorState(
          error: "There is something error, please try again"));
      emit(MarketerLoading());
      return;
    }
    if (shoppingListDetail.marketer == null ||
        shoppingListDetail.userId == null ||
        userId.isEmpty) {
      emit(const MarketerReady());
      return;
    }
    if (shoppingListDetail.userId == userId) {
      emit(MarketerReady(
          marketer: shoppingListDetail.marketer!, isMarketer: true, isReady: true));
    } else {
      emit(MarketerReady(
          marketer: shoppingListDetail.marketer!, isMarketer: false, isReady: true));
    }
  }
}
