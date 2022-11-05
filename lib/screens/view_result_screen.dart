import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewResultScreen extends StatelessWidget {
  final snap;
  final double raisedAmount;
  final int donationsCount;

  const ViewResultScreen({
    super.key,
    required this.snap,
    required this.raisedAmount,
    required this.donationsCount,
  });

  @override
  Widget build(BuildContext context) {
    List results = [
      {
        'name': 'Funds gained',
        'value': '\$ ${raisedAmount.toInt()}',
      },
      {
        'name': 'Funds left',
        'value': '\$ ${(snap['goal'] - raisedAmount).toInt()}',
      },
      {
        'name': 'Donators',
        'value': '$donationsCount',
      },
      {
        'name': 'Days left',
        'value': '${daysBetween(DateTime.now(), snap['expireDate'].toDate())}',
      },
      {
        'name': 'Funds reached',
        'value': '${(raisedAmount / snap['goal'] * 100).toStringAsFixed(1)}%',
      },
      {
        'name': 'Prayers',
        'value': '1620',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'View Results',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  width: 1,
                  color: borderColor,
                ),
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    IntrinsicHeight(
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.34,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                snap['images'][0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(right: 6, top: 6),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(
                                  width: 0.8,
                                  color: borderColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.bookmark_outline,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: constraints.maxWidth * 0.64,
                        padding:
                            const EdgeInsets.only(top: 12, left: 8, bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snap['title'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: RichText(
                                text: TextSpan(
                                  text: "\$${raisedAmount.toInt()}",
                                  style: GoogleFonts.urbanist(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' fund raised from ',
                                      style: GoogleFonts.urbanist(
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "\$${snap['goal'].toInt()}",
                                      style: GoogleFonts.urbanist(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                child: LinearProgressIndicator(
                                  value: (raisedAmount / snap['goal']),
                                  color: primaryColor,
                                  backgroundColor: progressBackgroundColor,
                                  minHeight: 5.2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: '$donationsCount',
                                      style: GoogleFonts.urbanist(
                                        color: primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Donators',
                                          style: GoogleFonts.urbanist(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          "${daysBetween(DateTime.now(), snap['expireDate'].toDate())}",
                                      style: GoogleFonts.urbanist(
                                        color: primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' days left',
                                          style: GoogleFonts.urbanist(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              endIndent: 4,
              indent: 4,
              height: 32,
              thickness: 1,
              color: borderColor,
            ),
            Text(
              'Fundraising Results',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            GridView.builder(
              itemCount: results.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 18),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: (MediaQuery.of(context).size.width / 3),
                childAspectRatio: 4 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: primaryColor,
                      width: 2.8,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        results[index]['value'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        results[index]['name'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                child: Text(
                  'Withdraw Funds',
                  style: GoogleFonts.urbanist(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
