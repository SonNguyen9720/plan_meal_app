part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object> get props => [];
}

class GroupsInitial extends GroupsState {}

class GroupLoadingItem extends GroupsState {
  final DateTime dateTime;

  const GroupLoadingItem({required this.dateTime});
}

class GroupLoadFailed extends GroupsState {}

class GroupNoItem extends GroupsState {
  final DateTime dateTime;

  const GroupNoItem({required this.dateTime});
}

class GroupHasItem extends GroupsState {
  final DateTime dateTime;
  final List<IngredientByDayEntity> listIngredient;

  const GroupHasItem({required this.dateTime, required this.listIngredient});
}

class GroupWaiting extends GroupsState {}

class GroupFinished extends GroupsState {}

class GroupNoGroup extends GroupsState {}

