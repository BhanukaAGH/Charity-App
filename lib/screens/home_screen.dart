import 'package:charity_app/screens/select_fundraise_screen.dart';
import 'package:charity_app/screens/view_single_fundraiser_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/common/action_button.dart';
import 'package:charity_app/widgets/home/category_list.dart';
import 'package:charity_app/widgets/home/curve_painter.dart';
import 'package:charity_app/widgets/home/slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Image.asset(
          'assets/logo.png',
          width: 48,
        ),
        elevation: 0,
        actions: [
          ActionButton(
            onPressed: () {
              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewSingleFundraiserScreen(),
                          ),
                        );
            },
            icons: Icons.search,
          ),
          const SizedBox(width: 12),
          ActionButton(
            onPressed: () {},
            icons: Icons.bookmark,
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.2,
              child: CustomPaint(
                painter: CurvePainter(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Your home\n for help',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectFundraiseScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Start a Fundraise',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -36.0, 0.0),
              child: const FundraisersSlider(),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -28.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fundraisers',
                    style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'see all',
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -26.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const CategoryList(),
            ),
          ],
        ),
      ),
    );
  }
}
