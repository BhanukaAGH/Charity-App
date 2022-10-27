import 'package:charity_app/utils/testData.dart';
import 'package:charity_app/widgets/my%20fundraises/donate_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    activities.sort((a, b) {
      var adate = a['date'];
      var bdate = b['date'];
      return adate.compareTo(bdate);
    });
    List<dynamic> sortList = activities.reversed.toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 ||
                  sortList[index]['date'] != sortList[index - 1]['date'])
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 6),
                  child: Text(
                    sortList[index]['date'].toString(),
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
                    imgUrl: sortList[index]['imgUrl'],
                    name: sortList[index]['name'],
                    price: sortList[index]['price'],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
