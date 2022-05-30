import 'package:equatable/equatable.dart';

abstract class SplashScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigationToNextScreenEvent extends SplashScreenEvent {}
