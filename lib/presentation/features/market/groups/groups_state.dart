part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  final DateTime dateStart;
  final DateTime dateEnd;

  const GroupsState({required this.dateStart, required this.dateEnd});

  @override
  List<Object> get props => [];
}

class GroupsInitial extends GroupsState {
  const GroupsInitial(dateStart, dateEnd)
      : super(dateStart: dateStart, dateEnd: dateEnd);
}

class GroupLoadingItem extends GroupsState {
  const GroupLoadingItem(dateStart, dateEnd)
      : super(dateStart: dateStart, dateEnd: dateEnd);
}

class GroupLoadFailed extends GroupsState {
  const GroupLoadFailed(dateStart, dateEnd)
      : super(dateStart: dateStart, dateEnd: dateEnd);
}

class GroupNoItem extends GroupsState {
  const GroupNoItem(dateStart, dateEnd)
      : super(dateStart: dateStart, dateEnd: dateEnd);
}

class GroupHasItem extends GroupsState {
  final List<IngredientByDay> listIngredient;

  const GroupHasItem(
      {required dateStart, required dateEnd, required this.listIngredient})
      : super(dateStart: dateStart, dateEnd: dateEnd);
}

class GroupWaiting extends GroupsState {
  const GroupWaiting({required DateTime dateStart, required DateTime dateEnd})
      : super(dateStart: dateStart, dateEnd: dateEnd);
}

class GroupFinished extends GroupsState {
  const GroupFinished({required DateTime dateStart, required DateTime dateEnd})
      : super(dateStart: dateStart, dateEnd: dateEnd);
}

class GroupNoGroup extends GroupsState {
  const GroupNoGroup({required DateTime dateStart, required DateTime dateEnd})
      : super(dateStart: dateStart, dateEnd: dateEnd);
}
