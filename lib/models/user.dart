import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String photoUrl;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.photoUrl,
  });

  Map<String, dynamic> tojson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'role': role,
        'photoUrl': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
      role: snapshot['role'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
