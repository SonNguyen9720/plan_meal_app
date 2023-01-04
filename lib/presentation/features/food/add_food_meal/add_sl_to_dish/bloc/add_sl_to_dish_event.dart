part of 'add_sl_to_dish_bloc.dart';

abstract class AddSlToDishEvent extends Equatable {
  const AddSlToDishEvent();
}

class AddSlToDishLoadSlEvent extends AddSlToDishEvent {
  @override
  List<Object> get props => [];
}

class AddSlToDishSelectEvent extends AddSlToDishEvent {
  final int index;

  const AddSlToDishSelectEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class AddSlToDishDeselectEvent extends AddSlToDishEvent {
  @override
  List<Object> get props => [];
}
