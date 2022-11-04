import 'package:equatable/equatable.dart';

class MemberEntity extends Equatable {
  final String name;
  final String email;
  final bool isAdmin;
  final int userId;

  const MemberEntity(
      {required this.name,
      required this.email,
      required this.isAdmin,
      required this.userId});

  @override
  List<Object?> get props => [];
}
