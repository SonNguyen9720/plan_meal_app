import 'package:equatable/equatable.dart';

class GroupUserEntity extends Equatable {
  final String groupName;
  final int number;

  const GroupUserEntity({required this.groupName, this.number = 1});
  @override
  List<Object?> get props => [groupName, number];
}