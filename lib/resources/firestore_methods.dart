import 'dart:typed_data';
import 'package:charity_app/models/fundraise.dart';
import 'package:charity_app/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //! Create Fundraise
  Future<String> createFundraise({
    required String uid,
    required String title,
    required String category,
    required double goal,
    required DateTime expireDate,
    required String story,
    required List<Uint8List?> images,
    required String recipientName,
    required String recipientPhone,
    required String recipientEmail,
    required bool isDraft,
  }) async {
    String res = 'some error occured';
    try {
      List<String> imageUrls = await StorageMethods()
          .uploadImageToStorage('fundraises', images, true);

      String fundraiseId = const Uuid().v1();

      Fundraise fundraise = Fundraise(
        fundraiseId: fundraiseId,
        uid: uid,
        title: title,
        category: category,
        goal: goal,
        expireDate: expireDate,
        publishDate: DateTime.now(),
        story: story,
        images: imageUrls,
        recipientName: recipientName,
        recipientPhone: recipientPhone,
        recipientEmail: recipientEmail,
        isDraft: isDraft,
      );

      _firestore
          .collection('fundraisers')
          .doc(fundraiseId)
          .set(fundraise.tojson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
