import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FundraisersSlider extends StatefulWidget {
  const FundraisersSlider({super.key});

  @override
  State<FundraisersSlider> createState() => _FundraisersSliderState();
}

class _FundraisersSliderState extends State<FundraisersSlider> {
  final CarouselController _controller = CarouselController();
  List fundraiserList = [];
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _getFundraises();
  }

  _getFundraises() async {
    final data = await FirebaseFirestore.instance
        .collection('fundraisers')
        .limit(6)
        .get();

    for (var element in data.docs) {
      fundraiserList.add({
        'title': element['title'],
        'image': element['images'][0],
      });
    }

    setState(() {
      fundraiserList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders(fundraiserList),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: fundraiserList.asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: entry.key == _current ? 8 : 6,
                  height: entry.key == _current ? 8 : 6,
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        entry.key == _current ? primaryColor : paginationColor,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

List<Widget> imageSliders(List fundraiserList) => fundraiserList
    .map(
      (item) => Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        item['image'],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.6),
                        Color.fromRGBO(0, 0, 0, 0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 24,
                  width: 250,
                  child: Text(
                    item['title'],
                    maxLines: 2,
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            )),
      ),
    )
    .toList();
