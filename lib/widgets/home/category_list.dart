import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/home/fundraiser_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/utils.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String _currentSelect = 'All';
  var categories = Set();

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  _getCategories() async {
    final data =
        await FirebaseFirestore.instance.collection('fundraisers').get();

    for (var element in data.docs) {
      categories.add(element['category']);
    }

    setState(() {
      categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              ...categories
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
        SizedBox(
          width: double.infinity,
          height: 265,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('fundraisers')
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<QueryDocumentSnapshot<Map<String, dynamic>>> filter;
              filter = snapshot.data!.docs;
              if (_currentSelect != 'All') {
                filter = snapshot.data!.docs.where((element) {
                  return element.data()['category'] == _currentSelect;
                }).toList();
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 2),
                itemCount: filter.length,
                itemBuilder: (context, index) {
                  final data = filter[index].data();

                  return FundraiserCard(
                    data: data,
                    imageUrl: data['images'][0],
                    title: data['title'],
                    goal: data['goal'],
                    daysLeft: daysBetween(
                        DateTime.now(), data['expireDate'].toDate()),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
