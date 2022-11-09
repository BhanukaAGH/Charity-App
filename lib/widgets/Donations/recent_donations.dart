import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentDonors extends StatefulWidget {
  final Snap;
  const RecentDonors({required this.Snap, super.key});

  @override
  State<RecentDonors> createState() => _RecentDonorsState();
}

class _RecentDonorsState extends State<RecentDonors> {
  var _Datauser = [];
  var NameOfDonor = 'anonymus';

  @override
  void initState() {
    super.initState();
    recentDonation();
  }

  recentDonation() async {
    CollectionReference _usercollectionRef =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await _usercollectionRef
        .where('uid', isEqualTo: widget.Snap['uid'])
        .get();
    _Datauser = querySnapshot.docs.map((doc) => doc.data()).toList();
    final Name = _Datauser.map((e) => e['name']).toString();

    NameOfDonor = Name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0))),
      padding: const EdgeInsets.all(5.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(NameOfDonor),
              Text(widget.Snap['ammount'].toString()),
            ],
          ),
        ),
      ]),
    );
  }
}
