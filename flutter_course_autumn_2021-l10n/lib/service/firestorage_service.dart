import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FireStorageService {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  getFile(String fileName) {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(fileName);
  }

  Future<void> listExample() async {
    firebase_storage.ListResult result =
        await firebase_storage.FirebaseStorage.instance.ref().listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    result.prefixes.forEach((firebase_storage.Reference ref) {
      print('Found directory: $ref');
    });
  }

  Future<String> downloadURLExample() async {
    String downloadURL = await storage.ref('main.png').getDownloadURL();
    print(downloadURL);
    return downloadURL;
    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path ?? '');
      storage
          .ref('userimages/deviceImage${Random(0).nextInt(1000)}.jpg')
          .putFile(file);
    } else {
      return;
    }
  }
}
