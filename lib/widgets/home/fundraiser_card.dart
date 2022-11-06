import 'package:charity_app/resources/fundraiser_methods.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/view_single_fundraiser_screen.dart';

class FundraiserCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final data;
  final double goal;
  final int daysLeft;

  const FundraiserCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.data,
    required this.goal,
    required this.daysLeft,
  });

  @override
  State<FundraiserCard> createState() => _FundraiserCardState();
}

class _FundraiserCardState extends State<FundraiserCard> {
  double raisedAmount = 0;
  int donationsCount = 0;
  @override
  initState() {
    super.initState();
    _calcDonations();
  }

  _calcDonations() async {
    final donations = await FundraiserMethods()
        .getFundraiseDonations(context, widget.data['fundraiseId']);

    for (var donate in donations) {
      raisedAmount += donate['ammount'];
    }

    setState(() {
      raisedAmount;
      donationsCount = donations.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewSingleFundraiserScreen(widget.data),
          ),
        )
      },
      child: Container(
        width: 320,
        height: 260,
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
            footer: Container(
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
                        value: (raisedAmount / widget.goal),
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
                            text: "$donationsCount",
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
                            text: "${widget.daysLeft}",
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
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
