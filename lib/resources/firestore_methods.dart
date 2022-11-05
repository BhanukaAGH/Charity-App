import 'dart:typed_data';
import 'package:charity_app/models/fundraise.dart';
import 'package:charity_app/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/savefundraise.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _Dataman = [];

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
