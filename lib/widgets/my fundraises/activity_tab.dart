import 'package:charity_app/resources/fundraiser_methods.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/my%20fundraises/donate_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({super.key});

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  List fundraisersIds = [];

  @override
  void initState() {
    super.initState();
    _getMyFundraisersIds(context);
  }

  DateTime _convertDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  _getMyFundraisersIds(BuildContext context) async {
    List docs = await FundraiserMethods().getMyFundraises(context);
    setState(() {
      fundraisersIds =
          docs.map((element) => element['fundraiseId'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: fundraisersIds.isEmpty
          ? Text(
              'No activities yet...',
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: paginationColor,
              ),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('donations')
                  .where('fundraiseId', whereIn: fundraisersIds)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List activities = snapshot.data!.docs
                    .map((e) => {
                          'uid': e.data()['uid'],
                          'date':
                              _convertDate(e.data()['publishDate'].toDate()),
                          'amount': e.data()['ammount']
                        })
                    .toList();

                activities.sort((a, b) {
                  var adate = a['date'];
                  var bdate = b['date'];
                  return adate.compareTo(bdate);
                });

                List sortList = activities.reversed.toList();
                return ListView.builder(
                  itemCount: sortList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    final data = sortList[index];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0 ||
                            data['date'] != sortList[index - 1]['date'])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4, top: 6),
                            child: Text(
                              DateFormat('EEEE, MMMM d yyyy')
                                  .format(data['date']),
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                        Column(
                          children: [
                            DonateTile(
                              uid: data['uid'],
                              amount: data['amount'],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
