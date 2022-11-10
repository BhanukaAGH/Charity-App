import 'package:charity_app/providers/user_provider.dart';
import 'package:charity_app/widgets/my%20fundraises/TeamFundraiseCard.dart';
import 'package:charity_app/widgets/my%20fundraises/my_fundraise_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/add_new_member_provider.dart';

class TeamFundraiseList extends StatefulWidget {
  const TeamFundraiseList({super.key});

  @override
  State<TeamFundraiseList> createState() => _TeamFundraiseListState();
}

class _TeamFundraiseListState extends State<TeamFundraiseList> {
  List<String> fundraiseLists = [];
  void getFundraiseList() async {
    fundraiseLists = await AddNewMember().fetchGroup();
  }

  @override
  void didChangeDependencies() {
    getFundraiseList();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('fundraisers')
            .where('fundraiseType', isEqualTo: 'teams')
            .where('membersList', arrayContainsAny: [user.uid]).snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => TeamFundraiseCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
