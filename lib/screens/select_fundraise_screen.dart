import 'package:charity_app/screens/create_fundraise_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectFundraiseScreen extends StatelessWidget {
  const SelectFundraiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 110) / 3;
    final double itemWidth = size.width * 0.7;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
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
          'Select Fundraise',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Column(
            children: [
              Text(
                'Who are you fundraise for?',
                style: GoogleFonts.urbanist(
                  color: paginationColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: itemWidth,
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  itemCount: types.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: itemWidth,
                    childAspectRatio: itemWidth / itemHeight,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      splashColor: lightPrimaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateFundraiseScreen(
                              fundraiseType: types[index]['type'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: primaryColor,
                            width: 2.8,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            Image.asset(
                              types[index]['image'],
                              height: itemHeight / 3,
                            ),
                            const Spacer(),
                            Text(
                              types[index]['title'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              types[index]['description'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: paginationColor,
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List types = [
  {
    'image': 'assets/type1.png',
    'title': 'Yourself',
    'type': FundraiseType.mySelf,
    'description': 'Funds are delivered to your bank account for your own use',
  },
  {
    'image': 'assets/type2.png',
    'title': 'Someone else',
    'type': FundraiseType.teams,
    'description':
        'You’ll invite a beneficiary to receive funds or distribute them yourself',
  },
  {
    'image': 'assets/type3.png',
    'title': 'Charity',
    'type': FundraiseType.charity,
    'description': 'Funds are delivered to your chosen nonprofit for you',
  },
];
