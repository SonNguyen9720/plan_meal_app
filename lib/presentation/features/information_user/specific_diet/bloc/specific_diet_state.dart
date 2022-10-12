part of 'specific_diet_bloc.dart';

abstract class SpecificDietState extends Equatable {
  const SpecificDietState(this.specificDiet);

  final String specificDiet;

  @override
  List<Object> get props => [];
}

class SpecificDietInitial extends SpecificDietState {
  const SpecificDietInitial(String specificDiet) : super(specificDiet);
}

class SpecificDietUpdated extends SpecificDietState {
  const SpecificDietUpdated(String specificDiet) : super(specificDiet);
}

class SpecificDietSubmitted extends SpecificDietState {
  final User user;
  const SpecificDietSubmitted(String specificDiet, this.user)
      : super(specificDiet);
}
