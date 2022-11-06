import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charity_app/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //! Get Current User Details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //! Sign Up User
  Future<String> signUpuser({
    required String name,
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // add user to our database
        model.User user = model.User(
            uid: cred.user!.uid,
            name: name,
            email: email,
            role: 'user',
            photoUrl: 'https://www.gravatar.com/avatar/?d=mp');

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.tojson());
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //! Logging User
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please enter all the fields.';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  //! Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      print(err.toString());
    }
  }
}
