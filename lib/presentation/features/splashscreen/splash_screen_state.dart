import 'package:equatable/equatable.dart';

abstract class SplashScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends SplashScreenState {}

class Loading extends SplashScreenState {}

class Loaded extends SplashScreenState {}