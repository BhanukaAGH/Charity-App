import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class AddNewMember with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map>> getAllUsers() async {
    final users = _firestore.collection('users');
    List<Map> userList = [];
    QuerySnapshot snapshot = await users.get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      userList.add(doc.data() as Map);
    });
    notifyListeners();
    return userList;
  }

  // Future<void> createGroup(
  //     String userId, String fundraiseId, List<String> memberIds) async {
  //   String groupId = const Uuid().v1();
  //   print(memberIds);
  //   try {
  //     final group = {
  //       'groupId': groupId,
  //       'leaderId': userId,
  //       'fundraiseId': fundraiseId,
  //       'membersIds': memberIds
  //     };
  //     await _firestore.collection('group').doc(groupId).set(group);
  //   } catch (err) {
  //     print(err);
  //   }
  // }

  Future<List<String>> fetchGroup() async {
    String? userId = _auth.currentUser?.uid;
    final group = _firestore.collection('group');
    List<Map> groupList = [];
    List<String> fundraiseIdList = [];
    QuerySnapshot snapshot = await group.get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      groupList.add(doc.data() as Map);
    });
    groupList.forEach((element) {
      if (element['leaderId'] == userId) {
        fundraiseIdList.add(element['fundraiseId']);
      } else {
        element['fundraiseId'].forEach((list) {
          if (list == userId) {
            fundraiseIdList.add(element['fundraiseId']);
          }
        });
      }
    });
    return fundraiseIdList;
  }

  Future<void> updateFundraise(
      String fundraiseId, List<String> membersList) async {
    await _firestore
        .collection('fundraisers')
        .doc(fundraiseId)
        .update({'membersList': membersList});
  }

  Future<void> deleteMember(
      String fundraiseId, List<String> membersList) async {
    await _firestore
        .collection('fundraisers')
        .doc(fundraiseId)
        .update({'membersList': membersList});
  }

  Future<bool> checkLeader(
    String fundraiseId,
  ) async {
    DocumentSnapshot doc;
    Map<dynamic, dynamic> fundraise;
    doc = await _firestore.collection('fundraisers').doc(fundraiseId).get();
    fundraise = doc.data() as Map;
    String userid = _auth.currentUser!.uid;
    if (userid == fundraise['uid']) {
      return true;
    } else {
      return false;
    }
  }
}
