import 'package:bloc/bloc.dart';
import 'splash_screen.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc(SplashScreenState initialState) : super(initialState) {
    on<NavigationToNextScreenEvent>((event, emit) async {
      emit(Loading());
      await Future.delayed(const Duration(milliseconds: 1500));
      emit(Loaded());
    });
  }

  SplashScreenState get initialState => Initial();
}
