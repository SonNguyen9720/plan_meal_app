import 'package:equatable/equatable.dart';

class GroupUserEntity extends Equatable {
  final String groupName;
  final int number;
  final int groupId;

  const GroupUserEntity({required this.groupName, this.number = 1, required this.groupId});
  @override
  List<Object?> get props => [groupName, number];
}