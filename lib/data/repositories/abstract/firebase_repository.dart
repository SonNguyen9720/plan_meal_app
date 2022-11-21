import 'package:image_picker/image_picker.dart';

abstract class FirebaseFireStoreRepository {
  Future<String> uploadImage(XFile imageFile);
}