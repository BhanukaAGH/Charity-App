import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/DonationsHistory/donation_history_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDonationsScreen extends StatelessWidget {
  const MyDonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        centerTitle: true,
        title: Text(
          'My Donations',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: const DonationHistorytab(),
    );
  }
}
