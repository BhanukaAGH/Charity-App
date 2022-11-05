import 'package:cloud_firestore/cloud_firestore.dart';

class Fundraise {
  final String fundraiseId;
  final String uid;
  final String title;
  final String category;
  final double goal;
  final DateTime expireDate;
  final DateTime publishDate;
  final String story;
  final List<String> images;
  final String recipientName;
  final String recipientPhone;
  final String recipientEmail;
  final bool isDraft;
  final String fundraiseType;

  Fundraise({
    required this.fundraiseId,
    required this.uid,
    required this.title,
    required this.category,
    required this.goal,
    required this.expireDate,
    required this.publishDate,
    required this.story,
    required this.images,
    required this.recipientName,
    required this.recipientPhone,
    required this.recipientEmail,
    required this.isDraft,
    required this.fundraiseType,
  });

  Map<String, dynamic> tojson() {
    return <String, dynamic>{
      'fundraiseId': fundraiseId,
      'uid': uid,
      'title': title,
      'category': category,
      'goal': goal,
      'expireDate': expireDate,
      'publishDate': publishDate,
      'story': story,
      'images': images,
      'recipientName': recipientName,
      'recipientPhone': recipientPhone,
      'recipientEmail': recipientEmail,
      'isDraft': isDraft,
      'fundraiseType': fundraiseType,
    };
  }

  static Fundraise fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Fundraise(
      fundraiseId: snapshot['fundraiseId'],
      uid: snapshot['uid'],
      title: snapshot['title'],
      category: snapshot['category'],
      goal: snapshot['goal'],
      expireDate: snapshot['expireDate'],
      publishDate: snapshot['publishDate'],
      story: snapshot['story'],
      images: ['images'],
      recipientName: snapshot['recipientName'],
      recipientPhone: snapshot['recipientPhone'],
      recipientEmail: snapshot['recipientEmail'],
      isDraft: snapshot['isDraft'],
      fundraiseType: snapshot['fundraiseType'],
    );
  }
}
