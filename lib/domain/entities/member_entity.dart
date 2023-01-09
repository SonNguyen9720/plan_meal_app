import 'package:equatable/equatable.dart';

class MemberEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool isAdmin;
  final int userId;
  final String imageUrl;

  const MemberEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.isAdmin,
      required this.userId, required this.imageUrl});

  @override
  List<Object?> get props => [id, name, email, isAdmin, userId, imageUrl];
}
