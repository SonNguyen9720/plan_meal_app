import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scan_food_event.dart';
part 'scan_food_state.dart';

class ScanFoodBloc extends Bloc<ScanFoodEvent, ScanFoodState> {
  ScanFoodBloc() : super(ScanFoodInitial()) {
    on<InitCameraEvent>(_onInitCameraEvent);
  }

  void _onInitCameraEvent(InitCameraEvent event, Emitter<ScanFoodState> emit) {
    emit(ScanFoodLoadingCamera());
    if (event.isSuccess) {
      emit(ScanFoodLoadedCamera());
    }
  }
}
