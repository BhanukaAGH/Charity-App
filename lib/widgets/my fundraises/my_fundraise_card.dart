import 'dart:io';

import 'package:charity_app/resources/fundraiser_methods.dart';
import 'package:charity_app/screens/edit_fundraise_screen.dart';
import 'package:charity_app/screens/view_result_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class MyFundraiseCard extends StatefulWidget {
  final snap;

  const MyFundraiseCard({
    super.key,
    required this.snap,
  });

  @override
  State<MyFundraiseCard> createState() => _MyFundraiseCardState();
}

class _MyFundraiseCardState extends State<MyFundraiseCard> {
  double raisedAmount = 0;
  int donationsCount = 0;
  @override
  initState() {
    super.initState();
    _calcDonations();
  }

  _calcDonations() async {
    final donations = await FundraiserMethods()
        .getFundraiseDonations(widget.snap['fundraiseId']);

    for (var donate in donations) {
      raisedAmount += donate['ammount'];
    }

    setState(() {
      raisedAmount;
      donationsCount = donations.length;
    });
  }

  _sharePost() async {
    final uri = Uri.parse(widget.snap['images'][0]);
    final response = await http.get(uri);
    final bytes = response.bodyBytes;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);
    await Share.shareXFiles(
      [XFile(path)],
      text: 'Help to raise Funds - ${widget.snap['title']}',
      subject: widget.snap['story'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 6, bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: borderColor,
            offset: Offset(0.5, 0.6),
            blurRadius: 1.0,
          ),
        ],
      ),
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
                          width: constraints.maxWidth * 0.36,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              widget.snap['images'][0],
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
                      width: constraints.maxWidth * 0.62,
                      padding:
                          const EdgeInsets.only(top: 14, left: 8, bottom: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['title'],
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
                                    text: "\$${widget.snap['goal'].toInt()}",
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
                                value: (raisedAmount / widget.snap['goal']),
                                color: primaryColor,
                                backgroundColor: progressBackgroundColor,
                                minHeight: 5.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        "${daysBetween(DateTime.now(), widget.snap['expireDate'].toDate())}",
                                    style: GoogleFonts.urbanist(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' days left',
                                        style: GoogleFonts.urbanist(
                                          color: Colors.black.withOpacity(0.5),
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
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditFundraiseScreen(snap: widget.snap),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  icon: const Icon(
                    Icons.edit,
                    color: primaryColor,
                    size: 16,
                  ),
                  label: Text(
                    'Edit',
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: paginationColor,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _sharePost,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft,
                  ),
                  icon: const Icon(
                    Icons.share_rounded,
                    color: primaryColor,
                    size: 16,
                  ),
                  label: Text(
                    'Share',
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: paginationColor,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewResultScreen(
                            snap: widget.snap,
                            raisedAmount: raisedAmount,
                            donationsCount: donationsCount,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 2,
                        color: primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'View Result',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
