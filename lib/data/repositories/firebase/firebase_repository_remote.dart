import 'dart:io';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';

class CloudFireStoreRepositoryRemote extends FirebaseFireStoreRepository {
  @override
  Future<String> uploadImage(XFile imageFile) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    final String fileName = basename(imageFile.name);
    final String destination = 'new-images/$fileName';
    try {
      final reference = storage.ref(destination);
      File photo = File(imageFile.path);
      await reference.putFile(photo);
      var imageUrl = await reference.getDownloadURL();
      return imageUrl;
    } catch (exception) {
      return exception.toString();
    }
  }

  @override
  Future<String> uploadAvatar(XFile avatarFile) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    final String fileName = basename(avatarFile.name);
    final String destination = 'avatar/$fileName';
    try {
      final reference = storage.ref(destination);
      File photo = File(avatarFile.path);
      await reference.putFile(photo);
      var imageUrl = await reference.getDownloadURL();
      return imageUrl;
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }
}
