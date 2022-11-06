import 'package:charity_app/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/view_single_fundraiser_screen.dart';

class FundraiserSearchCard extends StatefulWidget {
  final String imageUrl;
  final data;
  // final save;
  final String title;
  final double goal;
  // final double raisedAmount;
  // final int donatorsCount;
  // final int daysLeft;

  ///
  const FundraiserSearchCard({
    super.key,
    required this.imageUrl,
    // required this.save,
    required this.data,
    required this.title,
    required this.goal,
    // required this.raisedAmount,
    // required this.donatorsCount,
    // required this.daysLeft,
  });

  @override
  State<FundraiserSearchCard> createState() => _FundraiserSearchCardState();
}

class _FundraiserSearchCardState extends State<FundraiserSearchCard> {
  var _Dataman;
  var donors = 0;
  bool _isLoading = false;
  var fdata;
  var donated;
  var donatedOn;
  var raisedammount = 0.0;

  void initState() {
    super.initState();
    getdonated();
  }

  getdonated() async {
    setState(() {
      _isLoading = true;
    });
    var raised = 0.0;
    // var collection = FirebaseFirestore.instance.collection('donations');
    // var docSnapshot = await collection
    //     .where('fundraiseId', isEqualTo: widget.Snap['fundraiseId'])
    //     .get();
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('donations');
    QuerySnapshot querySnapshot = await _collectionRef
        .where('fundraiseId', isEqualTo: widget.data['fundraiseId'])
        .get();
    donatedOn = widget.data['publishDate'].toDate().toString().substring(
        0, widget.data['publishDate'].toDate().toString().length - 13);
    _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();

    donors = _Dataman.length;
    _Dataman.forEach((element) {
      raised = raised + element['ammount'];
    });

    print(raised);
    raisedammount = raised;
    // print(raisedammount);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _alreadySaved = 'unsave';
    return _isLoading
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewSingleFundraiserScreen(widget.data),
                ),
              )
            },
            child: Container(
              width: 520,
              height: 250,
              padding: const EdgeInsets.only(right: 4),
              child: Card(
                elevation: 3,
                clipBehavior: Clip.hardEdge,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: borderColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: GridTile(
                  footer: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewSingleFundraiserScreen(widget.data),
                        ),
                      )
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: RichText(
                              text: TextSpan(
                                text: "\$${raisedammount.toInt()}",
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
                                    text: "\$${widget.goal.toInt()}",
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
                                value: (raisedammount / widget.goal),
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
                                    text: "${donors}",
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
                                    text: 'Poseted On: ',
                                    style: GoogleFonts.urbanist(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "${donatedOn}",
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
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        width: 500,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_alreadySaved == 'unsave') {
                            _alreadySaved = "save";
                          } else {
                            _alreadySaved = "unsave";
                          }
                        },
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
                          child: Icon(_alreadySaved == "save"
                              ? Icons.bookmark
                              : Icons.bookmark_border),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //     padding: const EdgeInsets.symmetric(vertical: 0),
                  //     child: Image.network(
                  //       imageUrl,
                  //       fit: BoxFit.cover,
                  //     ))
                ),
              ),
            ),
          );
  }
}
