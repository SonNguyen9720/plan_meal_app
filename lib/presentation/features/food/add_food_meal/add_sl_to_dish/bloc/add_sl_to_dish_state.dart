part of 'add_sl_to_dish_bloc.dart';

abstract class AddSlToDishState extends Equatable {
  const AddSlToDishState();
}

class AddSlToDishInitial extends AddSlToDishState {
  @override
  List<Object> get props => [];
}

class AddSlToDishLoading extends AddSlToDishState {
  @override
  List<Object> get props => [];
}

class AddSlToDishLoaded extends AddSlToDishState {
  final List<SlFoodEntity> slList;

  const AddSlToDishLoaded({required this.slList});

  @override
  List<Object> get props => [slList];
}

class AddSlToDishChosen extends AddSlToDishState {
  final int index;
  final List<SlFoodEntity> slList;

  const AddSlToDishChosen({required this.index, required this.slList});

  @override
  List<Object?> get props => [index, slList];
}