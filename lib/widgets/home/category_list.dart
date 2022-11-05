import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/home/fundraiser_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/utils.dart';

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
  var fundRaisers = {};
  bool isLoading = false;
  var _Dataman = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('fundraisers');

      QuerySnapshot querySnapshot = await _collectionRef.get();
      _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            children: [
              ..._Dataman.map((e) => FundraiserCard(
                    data: e,
                    imageUrl: e["images"][0],
                    title: e['title'],
                    goal: e['goal'],
                    raisedAmount: 20,
                    donatorsCount: 2,
                    daysLeft: 10,
                  )).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
