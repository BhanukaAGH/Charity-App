import 'package:charity_app/providers/add_new_member_provider.dart';
import 'package:charity_app/screens/select_fundraise_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/common/action_button.dart';
import 'package:charity_app/widgets/common/colored_tabbar.dart';
import 'package:charity_app/widgets/my%20fundraises/activity_tab.dart';
import 'package:charity_app/widgets/my%20fundraises/fundraiser_list_tab.dart';
import 'package:charity_app/widgets/my%20fundraises/team_fundraise_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TeamFundraiseScreen extends StatelessWidget {
  const TeamFundraiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          toolbarHeight: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
          title: Text(
            'My Team Fundraising',
            style: GoogleFonts.urbanist(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectFundraiseScreen(),
                    ),
                  );
                },
                icons: Icons.add,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: const TabBarView(
          children: [
            TeamFundraiseList(),
          ],
        ),
      ),
    );
  }
}
