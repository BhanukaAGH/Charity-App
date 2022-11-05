// ignore_for_file: prefer_const_constructors

import 'package:charity_app/resources/donation_methods.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/common/form_field_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/utils.dart';

class DonateScreen extends StatefulWidget {
  final record;
  const DonateScreen(this.record, {super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  String _alreadyDonated = 'donate';
  String _opencontact = 'close';
  String _descseemore = 'notexpand';
  final TextEditingController _ammountController = TextEditingController();
  bool _isLoading = false;

  var _Dataman = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    check();
  }

//donate
  donate(_ammountController) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await DonationMethods().createDonation(
        fundraiseId: widget.record['fundraiseId'],
        uid: FirebaseAuth.instance.currentUser!.uid,
        ammount: double.parse(_ammountController.text),
      );

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Donated!', context);
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  //check if donated
  check() async {
    setState(() {
      isLoading = true;
    });
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('donations');

      QuerySnapshot querySnapshot = await _collectionRef
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('fundraiseId', isEqualTo: widget.record['fundraiseId'])
          .get();
      _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();
      if (_Dataman.length == 0) {
        setState(() {
          _alreadyDonated = "donate";
        });
      } else {
        setState(() {
          _alreadyDonated = "donated";
        });
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
        title: Text(
          "Donate",
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      //_descseemore == "expand" ? null : 4
      body: Container(
        width: size.width,
        height: size.height - kToolbarHeight - 24,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                '${widget.record["title"]}',
                textAlign: TextAlign.start,
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(
                thickness: 0.8,
                color: borderColor,
              ),
              const SizedBox(height: 6),
              Text(
                'Donate To ${widget.record["recipientName"]}',
                textAlign: TextAlign.start,
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Our Goal is ${widget.record["goal"]} Rs',
                textAlign: TextAlign.start,
                style: GoogleFonts.urbanist(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Form(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  children: [
                    FormFieldInput(
                      controller: _ammountController,
                      label: 'Amount(LKR)',
                      hintText: 'ammount',
                      withAsterisk: true,
                      textInputType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: (_opencontact == 'close'
              ? Container(
                  height: 64,
                  padding: const EdgeInsets.only(bottom: 4),
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, top: 0.0),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 120.0, vertical: 10),
                                backgroundColor: _alreadyDonated == "donate"
                                    ? Color.fromRGBO(243, 153, 116, 1)
                                    : Color.fromARGB(255, 21, 127, 0),
                              ),
                              onPressed: () {
                                donate(_ammountController);
                              },
                              child: Text(
                                _alreadyDonated == "donate"
                                    ? 'Donate'
                                    : 'Donated',
                                style: GoogleFonts.urbanist(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 144,
                  padding: const EdgeInsets.only(bottom: 4),
                  alignment: Alignment.center,
                  child: ListView(children: [
                    Container(
                      alignment: Alignment.topRight,
                      height: 22,
                      width: 22,
                      child: IconButton(
                        tooltip: 'Close',
                        onPressed: () {
                          setState(() {
                            _opencontact = 'close';
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.mail),
                      title: Text(widget.record['recipientEmail']),
                      shape: Border(bottom: BorderSide()),
                    ),
                    ListTile(
                      leading: Icon(Icons.call),
                      title: Text(widget.record['recipientEmail']),
                      shape: Border(bottom: BorderSide()),
                    ),
                  ])))),
    );
  }
}
