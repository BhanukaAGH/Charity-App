import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ChatMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //! Post Comment
  Future<void> postComment({
    required String fundraiseId,
    required String donorId,
    required String message,
  }) async {
    try {
      if (message.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('fundraiseComments')
            .doc(fundraiseId)
            .collection('comments')
            .doc(commentId)
            .set({
          'commentId': commentId,
          'fundraiseId': fundraiseId,
          'donorId': donorId,
          'message': message,
          'uid': _auth.currentUser!.uid,
          'datePublished': DateTime.now(),
        });
      } else {
        debugPrint('text is empty');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
