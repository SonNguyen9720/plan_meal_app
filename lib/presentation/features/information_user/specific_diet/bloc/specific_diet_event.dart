part of 'specific_diet_bloc.dart';

abstract class SpecificDietEvent extends Equatable {
  const SpecificDietEvent();

  @override
  List<Object> get props => [];
}

class ChooseSpecificDietEvent extends SpecificDietEvent {
  final String specificDiet;

  const ChooseSpecificDietEvent(this.specificDiet);
}

class SubmitSpecificDietEvent extends SpecificDietEvent {
  final User user;

  const SubmitSpecificDietEvent(this.user);
}
