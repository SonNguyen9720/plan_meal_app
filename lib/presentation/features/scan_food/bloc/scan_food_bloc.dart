import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/domain/entities/food_detect_entity.dart';

part 'scan_food_event.dart';

part 'scan_food_state.dart';

class ScanFoodBloc extends Bloc<ScanFoodEvent, ScanFoodState> {
  final FirebaseFireStoreRepository firebaseFireStoreRepository;
  final FoodRepository foodRepository;

  ScanFoodBloc(
      {required this.firebaseFireStoreRepository, required this.foodRepository})
      : super(ScanFoodInitial()) {
    on<ScanFoodChooseImageFromCameraEvent>(_getImageFromCamera);
    on<ScanFoodChooseImageFromGalleryEvent>(_getImageFromGallery);
  }

  Future<void> _getImageFromCamera(ScanFoodChooseImageFromCameraEvent event,
      Emitter<ScanFoodState> emit) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    String result = '';
    List<FoodDetectEntity> listFoodDetectEntity = [];
    if (pickedFile != null) {
      emit(ScanFoodLoading());
      result = await firebaseFireStoreRepository.uploadImage(pickedFile);
      print(result);
      if (result.isNotEmpty) {
        var listFoodDetectModel = await foodRepository.detectFood(result);
        for (var foodDetectModel in listFoodDetectModel) {
          var foodDetect = FoodDetectEntity(
              name: foodDetectModel.name ?? "",
              imageUrl: foodDetectModel.imageUrl ?? "",
              calories: foodDetectModel.calories ?? 0);
          listFoodDetectEntity.add(foodDetect);
        }
      }
      var emptyFoodDetect = const FoodDetectEntity(name: "", imageUrl: "", calories: 0);
      listFoodDetectEntity.add(emptyFoodDetect);
    }
    if (result.isNotEmpty) {
      if (listFoodDetectEntity.isNotEmpty) {
        emit(ScanFoodLoadImage(imageUrl: result, foodDetectEntity: listFoodDetectEntity));
      } else {
        emit(ScanFoodNoImage(imageUrl: result));
      }
    } else {
      emit(ScanFoodInitial());
    }
  }

  Future<void> _getImageFromGallery(ScanFoodChooseImageFromGalleryEvent event,
      Emitter<ScanFoodState> emit) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    String result = '';
    List<FoodDetectEntity> listFoodDetectEntity = [];
    if (pickedFile != null) {
      result = await firebaseFireStoreRepository.uploadImage(pickedFile);
      print(result);
    }
    if (result.isNotEmpty) {
      emit(ScanFoodLoadImage(imageUrl: result, foodDetectEntity: listFoodDetectEntity));
    } else {
      emit(ScanFoodInitial());
    }
  }
}
