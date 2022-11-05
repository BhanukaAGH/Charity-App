import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  final String donationId;
  final String fundraiseId;
  final String uid;
  final DateTime publishDate;
  final double ammount;

  Donation({
    required this.donationId,
    required this.fundraiseId,
    required this.uid,
    required this.publishDate,
    required this.ammount,
  });

  Map<String, dynamic> tojson() {
    return <String, dynamic>{
      'donationId': donationId,
      'fundraiseId': fundraiseId,
      'uid': uid,
      'publishDate': publishDate,
      'ammount': ammount,
    };
  }

  static Donation fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Donation(
      donationId: snapshot['donationId'],
      fundraiseId: snapshot['fundraiseId'],
      publishDate: snapshot['publishDate'],
      uid: snapshot['uid'],
      ammount: snapshot['ammount'],
    );
  }
}
