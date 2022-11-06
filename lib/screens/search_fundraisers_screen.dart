import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/home/fundraiserSearch_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/common/action_button.dart';

class SearchFundraisesScreen extends StatefulWidget {
  const SearchFundraisesScreen({super.key});

  @override
  State<SearchFundraisesScreen> createState() => _SearchFundraisesState();
}

class _SearchFundraisesState extends State<SearchFundraisesScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(hintText: "Search title"),
          onChanged: (value) {
            if (mounted) {
              setState(() {});
            }
          },
        ),
        actions: [
          ActionButton(
            onPressed: () {
              if (mounted) {
                setState(() {});
              }
            },
            icons: Icons.search,
          ),
          const SizedBox(width: 12),
        ],
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('fundraisers').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }

            List fundraises = snapshot.data!.docs;
            if (_controller.text.isNotEmpty) {
              fundraises = fundraises
                  .where((element) => element
                      .data()['title']
                      .toLowerCase()
                      .contains(_controller.text.toLowerCase()))
                  .toList();
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: fundraises.length,
              itemBuilder: (context, index) {
                final data = fundraises[index].data();

                return FundraiserSearchCard(
                  data: data,
                  imageUrl: data["images"][0],
                  title: data['title'],
                  goal: data['goal'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}


//  MyFundraiseCard(
//               snap: snapshot.data!.docs[index].data(),
//             ),