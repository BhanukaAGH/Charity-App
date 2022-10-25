import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FundraiserCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double goal;
  final double raisedAmount;
  final int donatorsCount;
  final int daysLeft;

  const FundraiserCard({
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
                  title,
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
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
