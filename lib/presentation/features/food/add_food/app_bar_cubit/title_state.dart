part of 'title_cubit.dart';

abstract class TitleState extends Equatable {
  static const List<String> mealTitle = ["Breakfast", "Lunch", "Dinner"];
  const TitleState();
}

class TitleInitial extends TitleState {
  final String title;

  const TitleInitial({required this.title});

  @override
  List<Object> get props => [title];
}
