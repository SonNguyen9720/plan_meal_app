import 'package:bloc/bloc.dart';
import 'package:plan_meal_app/presentation/features/authentication/authentication.dart';
import 'splash_screen.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(Initial()) {
    on<NavigationToNextScreenEvent>((event, emit) async {
      emit(Loading());
      await Future.delayed(const Duration(milliseconds: 2500));
      emit(Loaded());
    });
  }
}
