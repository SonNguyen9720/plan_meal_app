part of 'avatar_bloc.dart';

abstract class AvatarState extends Equatable {
  const AvatarState();

  @override
  List<Object> get props => [];
}

class AvatarInitial extends AvatarState {
  final String imageUrl;
  const AvatarInitial({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class AvatarWaiting extends AvatarState {}

class AvatarFinished extends AvatarState {}

class AvatarError extends AvatarState {
  final String errorMessage;

  const AvatarError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
