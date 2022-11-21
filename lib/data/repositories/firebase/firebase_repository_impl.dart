import 'package:image_picker/image_picker.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/firebase/firebase_repository_remote.dart';

class FirebaseFireStoreRepositoryImpl extends FirebaseFireStoreRepository {
  final CloudFireStoreRepositoryRemote cloudFireStoreRepositoryRemote;

  FirebaseFireStoreRepositoryImpl({required this.cloudFireStoreRepositoryRemote});

  @override
  Future<String> uploadImage(XFile imageFile) {
    return cloudFireStoreRepositoryRemote.uploadImage(imageFile);
  }

}