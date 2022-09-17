part of 'gender_cubit.dart';

abstract class GenderState extends Equatable {
  const GenderState();

  @override
  List<Object> get props => [];
}

class GenderInitial extends GenderState {
  const GenderInitial();
}

class GenderFemaleChosen extends GenderState {
  final bool isFemale = true;

  const GenderFemaleChosen();
}

class GenderMaleChosen extends GenderState {
  final bool isFemale = false;

  const GenderMaleChosen();
}

class GenderSubmit extends GenderState {
  final User user;

  const GenderSubmit(this.user);
}

// class GenderFinished extends GenderState {
//   const GenderFinished();
// }
