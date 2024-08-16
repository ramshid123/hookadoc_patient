import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final instance = FirebaseStorage.instance;

  static Future<String> uploadPicture({
    required String path,
    required String phone,
  }) async {
    final snapshot =
        await instance.ref().child('takers').child(phone).putFile(File(path));
    final imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
