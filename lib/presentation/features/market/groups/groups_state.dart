part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object> get props => [];
}

class GroupsInitial extends GroupsState {}

class GroupLoadingItem extends GroupsState {
  final DateTime dateStart;
  final DateTime dateEnd;

  const GroupLoadingItem({required this.dateStart, required this.dateEnd});
}

class GroupLoadFailed extends GroupsState {}

class GroupNoItem extends GroupsState {
  final DateTime dateStart;
  final DateTime dateEnd;

  const GroupNoItem({required this.dateStart, required this.dateEnd});
}

class GroupHasItem extends GroupsState {
  final DateTime dateStart;
  final DateTime dateEnd;
  final List<IngredientByDay> listIngredient;

  const GroupHasItem({required this.dateStart, required this.dateEnd, required this.listIngredient});
}

class GroupWaiting extends GroupsState {}

class GroupFinished extends GroupsState {}

class GroupNoGroup extends GroupsState {}

