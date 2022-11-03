import 'package:charity_app/screens/select_fundraise_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/common/action_button.dart';
import 'package:charity_app/widgets/common/colored_tabbar.dart';
import 'package:charity_app/widgets/my%20fundraises/activity_tab.dart';
import 'package:charity_app/widgets/my%20fundraises/fundraiser_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/SavedFundraisers/saved_fundiser_list.dart';

class SavedFundraiserScreen extends StatefulWidget {
  const SavedFundraiserScreen({super.key});

  @override
  State<SavedFundraiserScreen> createState() => _SavedFundraiserState();
}

class _SavedFundraiserState extends State<SavedFundraiserScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          toolbarHeight: 80,
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
            'Saved Fundraisers',
            style: GoogleFonts.urbanist(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: const TabBarView(
          children: [
            SavedFundraisersTab(),
          ],
        ),
      ),
    );
  }
}
