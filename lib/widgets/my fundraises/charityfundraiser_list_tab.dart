import 'package:charity_app/providers/user_provider.dart';
import 'package:charity_app/widgets/my%20fundraises/my_fundraise_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_charity_fundraise_card.dart';

class CharityFundraisersTab extends StatelessWidget {
  const CharityFundraisersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('fundraisers')
            // .where('fundraiserType', isEqualTo: 'charity')
            .where('uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => MyCharityFundraiseCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
