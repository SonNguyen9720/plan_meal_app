import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';

part 'scan_food_event.dart';
part 'scan_food_state.dart';

class ScanFoodBloc extends Bloc<ScanFoodEvent, ScanFoodState> {
  final FirebaseFireStoreRepository firebaseFireStoreRepository;

  ScanFoodBloc({required this.firebaseFireStoreRepository}) : super(ScanFoodInitial()) {
    on<ScanFoodChooseImageFromCameraEvent>(_getImageFromCamera);
    on<ScanFoodChooseImageFromGalleryEvent>(_getImageFromGallery);
  }

  Future<void> _getImageFromCamera(ScanFoodChooseImageFromCameraEvent event, Emitter<ScanFoodState> emit) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    String result = '';
    if (pickedFile != null) {
      result = await firebaseFireStoreRepository.uploadImage(pickedFile);
      print(result);
    }
    if (result.isNotEmpty) {
      emit(ScanFoodLoadImage(imageUrl: result));
    } else {
      emit(ScanFoodInitial());
    }
  }

  Future<void> _getImageFromGallery(ScanFoodChooseImageFromGalleryEvent event, Emitter<ScanFoodState> emit) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    String result = '';
    if (pickedFile != null) {
      result = await firebaseFireStoreRepository.uploadImage(pickedFile);
      print(result);
    }
    if (result.isNotEmpty) {
      emit(ScanFoodLoadImage(imageUrl: result));
    } else {
      emit(ScanFoodInitial());
    }
  }
}
