// ignore_for_file: prefer_const_constructors

import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/SearchFundraisers.dart/fundraiser_search_resultslist.dart';
import '../widgets/common/action_button.dart';


class SearchFundraisesScreen extends StatefulWidget {
  const SearchFundraisesScreen({super.key});

  @override
  State<SearchFundraisesScreen> createState() =>
      _SearchFundraisesState();
}

class _SearchFundraisesState
    extends State<SearchFundraisesScreen> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(hintText: "Search.."),),
        actions: [
          ActionButton(
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Shared", // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.CENTER, // location
                  timeInSecForIosWeb: 1 // duration
                  );
            },
            icons: Icons.search,
          ),
        ],
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      body:  SearchResultsTab(),
    );
  }
}