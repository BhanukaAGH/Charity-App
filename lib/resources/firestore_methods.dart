import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

      QuerySnapshot querySnapshot = await _collectionRef
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('fundraiseId', isEqualTo: fundraiseId)
      .get();
      _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();

      _Dataman.map((e) => SavedID = e['savedID']).toList();

      _collectionRef..doc(SavedID).delete();

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
