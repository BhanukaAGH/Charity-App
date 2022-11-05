import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonationHistoryCard extends StatefulWidget {
  final Snap;
  const DonationHistoryCard({required this.Snap, super.key});
  // final String imageUrl;
  // final String title;
  // final double goal;
  // final double raisedAmount;
  // final int donatorsCount;
  // final int daysLeft;

  // const DonationHistoryCard({
  //   super.key,
  //   required this.imageUrl,
  //   required this.title,
  //   required this.goal,
  //   required this.raisedAmount,
  //   required this.donatorsCount,
  //   required this.daysLeft,
  // });

  @override
  State<DonationHistoryCard> createState() => _DonationHistoryCardState();
}

class _DonationHistoryCardState extends State<DonationHistoryCard> {
  bool _isLoading = false;
  var fdata;
  var donated;
  var donatedOn;
  var raisedammount = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var collection = FirebaseFirestore.instance.collection('fundraisers');
      var docSnapshot = await collection.doc(widget.Snap['fundraiseId']).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        fdata = data;
        donated = widget.Snap['ammount'];
        donatedOn = widget.Snap['publishDate'].toDate().toString().substring(
            0, widget.Snap['publishDate'].toDate().toString().length - 13);
        // print(widget.Snap['publishDate'].toDate().toString().substring(
        //     0, widget.Snap['publishDate'].toDate().toString().length - 13));
      }
      getdonated();
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  getdonated() async {
    setState(() {
      _isLoading = true;
    });
    var _Dataman = [];
    var raised = 0.0;
    // var collection = FirebaseFirestore.instance.collection('donations');
    // var docSnapshot = await collection
    //     .where('fundraiseId', isEqualTo: widget.Snap['fundraiseId'])
    //     .get();
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('donations');

    QuerySnapshot querySnapshot = await _collectionRef
        .where('fundraiseId', isEqualTo: widget.Snap['fundraiseId'])
        .get();
    _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();

    _Dataman.forEach((element) {
      raised = raised + element['ammount'];
    });
    // print("length");
    // print(raised);
    raisedammount = raised;
    // print(raisedammount);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: CircularProgressIndicator(),
          )
        : Container(
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
            child: fdata?["title"] != null
                ? Column(
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
                          builder: (BuildContext context,
                                  BoxConstraints constraints) =>
                              IntrinsicHeight(
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    fdata?["images"][1] != null
                                        ? SizedBox(
                                            width: constraints.maxWidth * 0.36,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Image.network(
                                                fdata?["images"][0],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Text("error in img")
                                  ],
                                ),
                                Container(
                                  width: constraints.maxWidth * 0.62,
                                  padding: const EdgeInsets.only(
                                      top: 14, left: 8, bottom: 14),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fdata?["title"],
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
                                            // text: "\$${widget.raisedAmount.toInt()}",
                                            text: raisedammount.toString(),
                                            style: GoogleFonts.urbanist(
                                              color: primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ' fund raised from ',
                                                style: GoogleFonts.urbanist(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              TextSpan(
                                                // text: "\$${widget.goal.toInt()}",
                                                text: fdata?["goal"].toString(),
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
                                            // value: (widget.raisedAmount / widget.goal),
                                            value: (raisedammount /
                                                fdata?["goal"]),
                                            color: primaryColor,
                                            backgroundColor:
                                                progressBackgroundColor,
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
                                                text: 'You Donated ',
                                                style: GoogleFonts.urbanist(
                                                  color: primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: donated.toString(),
                                                    style: GoogleFonts.urbanist(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // RichText(
                                            //   text: TextSpan(
                                            //     // text: "${widget.daysLeft}",
                                            //     text: 'ho',
                                            //     style: GoogleFonts.urbanist(
                                            //       color: primaryColor,
                                            //       fontSize: 14,
                                            //       fontWeight: FontWeight.w700,
                                            //     ),
                                            //     children: <TextSpan>[
                                            //       TextSpan(
                                            //         text: ' days left',
                                            //         style: GoogleFonts.urbanist(
                                            //           color: Colors.black
                                            //               .withOpacity(0.5),
                                            //           fontWeight: FontWeight.w600,
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
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
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              icon: const Icon(
                                Icons.mail,
                                color: primaryColor,
                                size: 16,
                              ),
                              label: Text(
                                'View Letters',
                                style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: paginationColor,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                              child: Container(
                                padding: const EdgeInsets.symmetric(),
                                child: Text(
                                  "Donated On:  ${donatedOn.toString()}",
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
                  )
                : Text("Post Has Been Removed Probably Raised Enough Funds Yay :)",
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.green,
                    )),
          );
  }
}

