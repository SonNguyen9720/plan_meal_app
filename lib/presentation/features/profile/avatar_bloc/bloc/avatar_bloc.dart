import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  AvatarBloc() : super(AvatarInitial()) {
    on<AvatarEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
