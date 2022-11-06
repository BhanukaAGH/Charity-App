import 'dart:typed_data';
import 'package:charity_app/models/fundraise.dart' as model;
import 'package:charity_app/providers/user_provider.dart';
import 'package:charity_app/resources/storage_methods.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    required String fundraiseType,
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

  //! Update Fundraise
  Future<String> updateFundraise({
    required String uid,
    required String fundraiseId,
    required String title,
    required String category,
    required double goal,
    required DateTime expireDate,
    required DateTime publishDate,
    required String story,
    required List<Uint8List?> images,
    required String recipientName,
    required String recipientPhone,
    required String recipientEmail,
    required bool isDraft,
    required String fundraiseType,
  }) async {
    String res = 'some error occured';
    try {
      List<String> imageUrls = await StorageMethods().uploadImages('fundraises',
          images.where((element) => element != null).toList(), fundraiseId);

      model.Fundraise fundraise = model.Fundraise(
        fundraiseId: fundraiseId,
        uid: uid,
        title: title,
        category: category,
        goal: goal,
        expireDate: expireDate,
        publishDate: publishDate,
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
          .update(fundraise.tojson());

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //! Delete Fundraise
  Future<String> deleteFundraise(String fundraiseId) async {
    String res = 'some error occured';
    try {
      // Delete Donations
      QuerySnapshot donations = await _firestore
          .collection('donations')
          .where('fundraiseId', isEqualTo: fundraiseId)
          .get();

      for (var doc in donations.docs) {
        doc.reference.delete();
      }

      // Delete Fundraiser
      await _firestore.collection('fundraisers').doc(fundraiseId).delete();

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //! Get Fundraiser Donations
  Future<List<DocumentSnapshot>> getFundraiseDonations(
    BuildContext context,
    String fundraiseId,
  ) async {
    List<DocumentSnapshot> donations = [];
    try {
      // Get Donations
      final snapshot = await _firestore
          .collection('donations')
          .where('fundraiseId', isEqualTo: fundraiseId)
          .get();

      for (var doc in snapshot.docs) {
        donations.add(doc);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
    return donations;
  }

  //! Get My Fundraisers
  Future<List<DocumentSnapshot>> getMyFundraises(BuildContext context) async {
    List<DocumentSnapshot> fundraisers = [];
    try {
      // Get Donations
      final snapshot = await _firestore
          .collection('fundraisers')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .get();

      for (var doc in snapshot.docs) {
        fundraisers.add(doc);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
    return fundraisers;
  }
}
