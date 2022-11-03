import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/home/fundraiser_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/view_single_fundraiser_screen.dart';

final List<String> categoryList = [
  "Education",
  "Medical",
  "Emergencies",
  "Environment",
];

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String _currentSelect = 'All';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewSingleFundraiserScreen(),
          ),
        );
      },
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentSelect = 'All';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _currentSelect == 'All' ? primaryColor : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: primaryColor,
                        width: 2.5,
                      ),
                    ),
                  ),
                  child: Text(
                    'All',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:
                          _currentSelect == 'All' ? Colors.white : primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 6.0),
                ...categoryList
                    .map(
                      (category) => Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _currentSelect = category;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentSelect == category
                                ? primaryColor
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                color: primaryColor,
                                width: 2.5,
                              ),
                            ),
                          ),
                          child: Text(
                            category,
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _currentSelect == category
                                  ? Colors.white
                                  : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: const [
                FundraiserCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1467307983825-619715426c70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1077&q=80',
                  title: 'African Children Beauty Charity Volunteer Hope',
                  goal: 4800,
                  raisedAmount: 3200,
                  donatorsCount: 1240,
                  daysLeft: 10,
                ),
                FundraiserCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1507427254987-7be33d0321d3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                  title: 'African Children Beauty Charity Volunteer Hope',
                  goal: 4800,
                  raisedAmount: 3200,
                  donatorsCount: 1240,
                  daysLeft: 10,
                ),
                FundraiserCard(
                  imageUrl:
                      'https://images.unsplash.com/flagged/photo-1555251255-e9a095d6eb9d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  title: 'African Children Beauty Charity Volunteer Hope',
                  goal: 4800,
                  raisedAmount: 3200,
                  donatorsCount: 1240,
                  daysLeft: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
