import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/domain/entities/member_entity.dart';

part 'group_detail_event.dart';
part 'group_detail_state.dart';

class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  GroupDetailBloc() : super(GroupDetailInitial()) {
    on<GroupDetailLoadDataEvent>(_onGroupDetailLoadDataEvent);
  }

  void _onGroupDetailLoadDataEvent(
      GroupDetailLoadDataEvent event, Emitter<GroupDetailState> emit) {
    emit(GroupDetailLoading());
    Future.delayed(const Duration(seconds: 2));
    emit(GroupDetailNoMember());
  }
}
