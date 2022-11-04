import 'package:charity_app/screens/select_fundraise_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/common/action_button.dart';
import 'package:charity_app/widgets/common/colored_tabbar.dart';
import 'package:charity_app/widgets/my%20fundraises/activity_tab.dart';
import 'package:charity_app/widgets/my%20fundraises/fundraiser_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFundraisesScreen extends StatelessWidget {
  const MyFundraisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            'My Fundraising',
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
          bottom: ColoredTabBar(
            tabcolor: Colors.white,
            tabBar: TabBar(
              labelColor: primaryColor,
              indicatorColor: primaryColor,
              indicatorWeight: 3,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    'My Fundraise',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                    child: Text(
                  'Activity',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            FundraisersTab(),
            ActivityTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectFundraiseScreen(),
              ),
            );
          },
          backgroundColor: primaryColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
