part of 'add_member_bloc.dart';

abstract class AddMemberState extends Equatable {
  const AddMemberState();

  @override
  List<Object> get props => [];
}

class AddMemberInitial extends AddMemberState {}

class AddMemberProcessing extends AddMemberState {}

class AddMemberSuccess extends AddMemberState {}

class AddMemberFailed extends AddMemberState {}
