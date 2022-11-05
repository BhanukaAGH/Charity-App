import 'dart:typed_data';
import 'package:charity_app/models/fundraise.dart';
import 'package:charity_app/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/savefundraise.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _Dataman = [];

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

  //Save Fundraiser method
  Future<String> savedFundraise({
    required String fundraiseId,
    required String uid,
  }) async {
    String res = 'some error occured';
    try {
      String savedID = const Uuid().v1();

      SaveFundraise fundraise = SaveFundraise(
        savedID: savedID,
        fundraiseId: fundraiseId,
        uid: uid,
      );

      _firestore
          .collection('savedfundraisers')
          .doc(savedID)
          .set(fundraise.tojson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //UnSave Fundraiser method
  Future<String> unsavedFundraise({
    required String fundraiseId,
  }) async {
    String res = 'some error occured';
    String SavedID = 'aa';
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('savedfundraisers');

      QuerySnapshot querySnapshot = await _collectionRef.get();
      _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();

      _Dataman.map((e) => SavedID = e['savedID']).toList();
      // print("[[[[[[[]]]]]]]]]]]]]]");
      // print(SavedID);

      _collectionRef..doc(SavedID).delete();

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // //check if fundraiser is already saved
  // //UnSave Fundraiser method
  // Future<String> isFundraiseSaved({
  //   required String fundraiseId,
  //   required String uid,
  // }) async {
  //   String res = 'some error occured';
  //   String response = 'aa';

  //   try {
  //     print("[[[[[[[]]]]]]]]]]]]]]fundid");
  //     print(fundraiseId);
  //     CollectionReference _collectionRef =
  //         FirebaseFirestore.instance.collection('savedfundraisers');

  //     QuerySnapshot querySnapshot = await _collectionRef
  //         .where('uid',isEqualTo:uid )
  //         .where('fundraiseId', isEqualTo: fundraiseId)
  //         .get();
  //     _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();
  //     print("[[[[[[[]]]]]]]]]]]]]]here1");
  //     print(_Dataman);

  //     //_collectionRef..doc(SavedID).delete();

  //     res = 'success';
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }
}
