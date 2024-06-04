import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  // get collection

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadImage(Uint8List fileData, String path) async {
    try {
      TaskSnapshot snapshot = await storage.ref().child(path).putData(fileData);
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
