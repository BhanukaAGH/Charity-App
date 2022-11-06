import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'donationsHistory_card.dart';

class DonationHistorytab extends StatelessWidget {
  const DonationHistorytab({super.key});

  @override
  Widget build(BuildContext context) {
      bool _isLoading = false;
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
              child: Container(
                height: size.height - kToolbarHeight - 24,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('donations')
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
                        itemBuilder: (context, index) => DonationHistoryCard(
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
//  DonationHistoryCard(
//               imageUrl:
//                   'https://images.unsplash.com/flagged/photo-1555251255-e9a095d6eb9d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
//               title: 'African Children Beauty Charity Volunteer Hope',
//               goal: 4800,
//               raisedAmount: 3200,
//               donatorsCount: 1240,
//               daysLeft: 10,
//             ),