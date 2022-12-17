part of 'title_cubit.dart';

abstract class TitleState extends Equatable {
  const TitleState();
}

class TitleInitial extends TitleState {
  final MealModel meal;

  const TitleInitial({required this.meal});

  @override
  List<Object> get props => [meal];
}
