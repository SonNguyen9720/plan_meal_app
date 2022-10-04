import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';

part 'add_group_event.dart';
part 'add_group_state.dart';

class AddGroupBloc extends Bloc<AddGroupEvent, AddGroupState> {
  AddGroupBloc() : super(AddGroupInitial()) {
    on<AddGroupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
