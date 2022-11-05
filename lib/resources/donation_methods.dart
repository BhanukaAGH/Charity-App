import 'dart:typed_data';
import 'package:charity_app/models/donation.dart';
import 'package:charity_app/models/fundraise.dart';
import 'package:charity_app/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DonationMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _Dataman = [];

  //! Create Fundraise
  Future<String> createDonation({
    required String uid,
    required String fundraiseId,
    required double ammount,
  }) async {
    String res = 'some error occured';
    try {
      String donationId= const Uuid().v1();

      Donation donate = Donation(
        fundraiseId: fundraiseId,
        uid: uid,
        ammount: ammount,
        donationId: donationId, 
        publishDate: DateTime.now(),
      );

      _firestore
          .collection('donations')
          .doc(donationId)
          .set(donate.tojson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
