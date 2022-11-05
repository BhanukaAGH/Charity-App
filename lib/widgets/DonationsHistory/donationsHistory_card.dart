import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charity_app/utils/colors.dart';

class DonationHistoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double goal;
  final double raisedAmount;
  final int donatorsCount;
  final int daysLeft;

  const DonationHistoryCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.goal,
    required this.raisedAmount,
    required this.donatorsCount,
    required this.daysLeft,
  });

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
                              imageUrl,
                              fit: BoxFit.cover,
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
                            title,
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
                                    text: "\$${goal.toInt()}",
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
                                value: (raisedAmount / goal),
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
                                    text: "$donatorsCount",
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
                                    text: "$daysLeft",
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
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  icon: const Icon(
                    Icons.mail,
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
                  onPressed: () {},
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(),
                    child: Text(
                      'Posted On',
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
