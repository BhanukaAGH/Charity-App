// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:charity_app/resources/auth_methods.dart';
import 'package:charity_app/screens/login_screen.dart';
import 'package:charity_app/screens/saved_postings.dart';
import 'package:charity_app/screens/select_fundraise_screen.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../widgets/home/curve_painter.dart';
import 'donation_history_screen.dart';
import 'my_fundraises_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
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
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: secondaryColor,
              title: Image.asset(
                'assets/logo.png',
                width: 48,
              ),
              elevation: 0,
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
                            child: Image.asset(
                              'assets/logo.png',
                              width: 48,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectFundraiseScreen(),
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
                                'Edit',
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
                      transform: Matrix4.translationValues(0.0, -26.0, 0.0),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListBody(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SavedFundraiserScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Icon(Icons.bookmark),
                              title: Text('Saved Posting'),
                              shape: Border(bottom: BorderSide()),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DonationHistoryScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Icon(Icons.history),
                              title: Text('Donations History'),
                              shape: Border(bottom: BorderSide()),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.volunteer_activism),
                            title: Text('Start Fundraiser'),
                            shape: Border(bottom: BorderSide()),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MyFundraisesScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Icon(Icons.local_offer),
                              title: Text('My Fundraisers'),
                              shape: Border(bottom: BorderSide()),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await AuthMethods().signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Icon(Icons.logout),
                              title: Text('Sign Out'),
                              shape: Border(bottom: BorderSide()),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
  }
}


  // ElevatedButton(
  //                 onPressed: () async {
  //                   await AuthMethods().signOut();
  //                   Navigator.of(context).pushReplacement(
  //                     MaterialPageRoute(
  //                       builder: (context) => const LoginScreen(),
  //                     ),
  //                   );
  //                 },
  //                 child: const Text('Sign Out'),
  //               ),

  // ListView(children: [
  //                       ListTile(
  //                         leading: Icon(Icons.call),
  //                         title: Text('Map'),
  //                         shape: Border(bottom: BorderSide()),
  //                       ),
  //                       ListTile(
  //                         leading: Icon(Icons.call),
  //                         title: Text('Map'),
  //                         shape: Border(bottom: BorderSide()),
  //                       ),
  //                       ListTile(
  //                         leading: Icon(Icons.call),
  //                         title: Text('Map'),
  //                         shape: Border(bottom: BorderSide()),
  //                       ),
  //                     ])