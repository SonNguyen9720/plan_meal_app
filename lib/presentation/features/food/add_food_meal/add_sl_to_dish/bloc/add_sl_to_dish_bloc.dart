import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_sl_to_dish_event.dart';
part 'add_sl_to_dish_state.dart';

class AddSlToDishBloc extends Bloc<AddSlToDishEvent, AddSlToDishState> {
  AddSlToDishBloc() : super(AddSlToDishInitial()) {
    on<AddSlToDishEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
