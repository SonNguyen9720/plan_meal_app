import 'dart:io';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CloudFireStoreRepository {

  static Future<void> upLoadImage(XFile? file) async {
    if (file == null) {
      return;
    }
    final String fileName = basename(file.path);
    final String destination = 'images/$fileName';

    try {
      final reference = FirebaseStorage.instance.ref(destination).child('image');
      File photo = File(file.path);
      await reference.putFile(photo);
    } catch (exception) {
      print(exception);
    }
  }
}