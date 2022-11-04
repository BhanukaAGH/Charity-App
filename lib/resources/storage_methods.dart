import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // adding image to firebase storage
  Future<List<String>> uploadImageToStorage(
      String childName, List<Uint8List?> files, bool isFundraise) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isFundraise) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    List<String> imageUrls = [];
    for (var file in files) {
      if (file == null) continue;
      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }
}
