import 'package:cloud_firestore/cloud_firestore.dart';

class SaveFundraise {
  final String fundraiseId;
  final String savedID;
  final String uid;

  SaveFundraise({
    required this.savedID,
    required this.fundraiseId,
    required this.uid,
  });

  Map<String, dynamic> tojson() {
    return <String, dynamic>{
      'savedID': savedID,
      'fundraiseId': fundraiseId,
      'uid': uid,
    };
  }

  static SaveFundraise fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SaveFundraise(
      savedID: snapshot['savedID'],
      fundraiseId: snapshot['fundraiseId'],
      uid: snapshot['uid'],
    );
  }
}
