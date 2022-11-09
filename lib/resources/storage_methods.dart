import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//! Add Multiple Images To Firebase Storage
  Future<List<String>> uploadImages(
      String childName, List<Uint8List?> images, String fundraiseId) async {
    var imageUrls = await Future.wait(images
        .map((image) => uploadImageToStorage(childName, image, fundraiseId)));
    return imageUrls;
  }

  //! Adding Single Image To Firebase Storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List? file, String fundraiseId) async {
    Reference ref = _storage
        .ref()
        .child(childName)
        .child(_auth.currentUser!.uid)
        .child(fundraiseId);

    String id = const Uuid().v1();
    ref = ref.child(id);

    UploadTask uploadTask = ref.putData(file!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  //! Adding single image to firebase USERS storage
  Future<String> uploadUserImageToStorage(
      String childName, Uint8List? file) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    String id = const Uuid().v1();
    ref = ref.child(id);

    UploadTask uploadTask = ref.putData(file!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
