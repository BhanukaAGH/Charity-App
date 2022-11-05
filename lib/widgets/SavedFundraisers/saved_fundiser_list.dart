import 'package:charity_app/widgets/SavedFundraisers/savedFundraiser_Card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

// final List<String> categoryList = [
//   "Education",
//   "Medical",
//   "Emergencies",
//   "Environment",
// ];

class SavedFundraisersTab extends StatefulWidget {
  const SavedFundraisersTab({super.key});

  @override
  State<SavedFundraisersTab> createState() => _SavedFundraisersState();
}

class _SavedFundraisersState extends State<SavedFundraisersTab> {
  var _Dataman = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    // print("_Dataman_Dataman_Dataman_Dataman_Dataman_Dataman");
    setState(() {
      _isLoading = true;
    });
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('savedfundraisers');

      QuerySnapshot querySnapshot = await _collectionRef
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();
      setState(() {
        _isLoading = false;
      });
      // print(_Dataman);
    } catch (e) {
      // print(e);
      showSnackBar(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return _isLoading
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: CircularProgressIndicator(),
          )
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: 
              
              Container(
                height: size.height - kToolbarHeight - 24,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('savedfundraisers')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => SaveFundraiseCard(
                            Snap: snapshot.data!.docs[index].data()));
                  },
                ),
              ),
              //  Column(
              //   children:  [
              //     ..._Dataman
              //             .map((e) => SaveFundraiseCard(
              //                   // data: e,
              //                   imageUrl: e["images"][0],
              //                   title: e['title'],
              //                   goal:e['goal'],
              //                   raisedAmount: 20,
              //                   donatorsCount: 2,
              //                   daysLeft: 10,
              //                 ))
              //             .toList(),
              //   ],
              // ),
            ),
          );
  }
}



