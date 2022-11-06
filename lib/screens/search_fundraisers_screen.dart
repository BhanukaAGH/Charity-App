// ignore_for_file: prefer_const_constructors

import 'package:charity_app/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/utils.dart';
import '../widgets/SearchFundraisers.dart/fundraiser_search_resultslist.dart';
import '../widgets/common/action_button.dart';

class SearchFundraisesScreen extends StatefulWidget {
  const SearchFundraisesScreen({super.key});

  @override
  State<SearchFundraisesScreen> createState() => _SearchFundraisesState();
}

class _SearchFundraisesState extends State<SearchFundraisesScreen> {
  final TextEditingController _controller = TextEditingController();
  var _Dataman = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    // print('[[][][][][][');
    // print(_controller.text.length);
    try {
      if (_controller.text.length == 0) {
        CollectionReference _collectionRef =
            FirebaseFirestore.instance.collection('fundraisers');

        QuerySnapshot querySnapshot = await _collectionRef.get();
        _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();
      }else{

      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

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
          controller: _controller,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(hintText: "Search title"),
        ),
        actions: [
          ActionButton(
            onPressed: () {
              getData();
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
      body: _controller.text.length==0?
      SearchResultsTab(data: _Dataman, keyword: 'empty'):SearchResultsTab(data: _Dataman, keyword: _controller.text,),
    );
  }
}
