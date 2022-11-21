import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';

class CloudFireStoreRepositoryRemote extends FirebaseFireStoreRepository {

  @override
  Future<String> uploadImage(XFile imageFile) async {
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    final String fileName = basename(imageFile.name);
    final String destination = 'new-images/$fileName';
    try {
      final reference = storage.ref(destination);
      File photo = File(imageFile.path);
      await reference.putFile(photo).snapshotEvents.listen((event) {
        switch (event.state) {
          case TaskState.paused:
            break;
          case TaskState.running:
            break;
          case TaskState.success:
            break;
          case TaskState.canceled:
            throw "File upload cancel";
          case TaskState.error:
            throw "Error upload file";
        }
      });
      var imageUrl = await reference.getDownloadURL();
      return imageUrl;
    } catch (exception) {
      return exception.toString();
    }
  }
}