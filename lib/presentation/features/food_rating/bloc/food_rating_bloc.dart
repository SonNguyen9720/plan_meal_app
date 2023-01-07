import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';

part 'food_rating_event.dart';
part 'food_rating_state.dart';

class FoodRatingBloc extends Bloc<FoodRatingEvent, FoodRatingState> {
  final UserRepository userRepository;
  FoodRatingBloc({required this.userRepository}) : super(FoodRatingInitial()) {
    on<FoodRatingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
