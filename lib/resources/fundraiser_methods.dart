import 'dart:typed_data';
import 'package:charity_app/models/fundraise.dart' as model;
import 'package:charity_app/resources/storage_methods.dart';
import 'package:charity_app/utils/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FundraiserMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    required FundraiseType fundraiseType,
  }) async {
    String res = 'some error occured';
    try {
      String fundraiseId = const Uuid().v1();

      List<String> imageUrls = await StorageMethods().uploadImages('fundraises',
          images.where((element) => element != null).toList(), fundraiseId);

      model.Fundraise fundraise = model.Fundraise(
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
        fundraiseType: fundraiseType,
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

  //! Get Fundraisers by User ID
  // Future<List<model.Fundraise>> getFundraisers() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot snap =
  //       await _firestore.collection('fundraisers').where('uid' ,isEqualTo: currentUser.uid).get();

  //   return snap;
  // }
}
