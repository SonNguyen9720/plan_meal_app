part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];

}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
