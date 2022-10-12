import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';

part 'add_group_event.dart';
part 'add_group_state.dart';

class AddGroupBloc extends Bloc<AddGroupEvent, AddGroupState> {
  AddGroupBloc() : super(const AddGroupInitial()) {
    on<NameGroupSubmitEvent>(_onNameGroupSubmitEvent);
  }

  void _onNameGroupSubmitEvent(
      NameGroupSubmitEvent event, Emitter<AddGroupState> emit) {
    emit(AddGroupSubmitted(groupName: event.name));
  }
}
