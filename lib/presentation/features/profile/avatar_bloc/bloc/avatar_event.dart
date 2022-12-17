part of 'avatar_bloc.dart';

abstract class AvatarEvent extends Equatable {
  const AvatarEvent();

  @override
  List<Object?> get props => [];
}

class AvatarPickFromCameraEvent extends AvatarEvent {
  final XFile? xFile;
  const AvatarPickFromCameraEvent({this.xFile});

  @override
  List<Object?> get props => [xFile];
}