import 'package:charity_app/screens/donate_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/Donations/recent_donations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';
import '../widgets/common/action_button_2.dart';
import '../widgets/home/single_fundraiser_slider.dart';

class ViewSingleFundraiserScreen extends StatefulWidget {
  final record;
  const ViewSingleFundraiserScreen(this.record, {super.key});

  @override
  State<ViewSingleFundraiserScreen> createState() =>
      _ViewSingleFundraiserScreenState();
}

class _ViewSingleFundraiserScreenState
    extends State<ViewSingleFundraiserScreen> {
  String _alreadyDonated = 'donate';
  String _alreadySaved = 'unsave';
  String _opencontact = 'close';
  String _descseemore = 'notexpand';
  String posteddate = 'not added';
  List<String> donors = ["empty"];
  double raisedammount = 0;
  bool _isLoading = false;

  var _Dataman = [];
  var _Datauser = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    check();
    checkifdonated();
    raised();
    recentDonation();
  }

  check() async {
    setState(() {
      isLoading = true;
    });

    DateTime dateTime = widget.record['publishDate'].toDate();
    final datentime = dateTime.toString();
    posteddate = datentime.substring(0, datentime.length - 13);
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('savedfundraisers');

      QuerySnapshot querySnapshot = await _collectionRef
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('fundraiseId', isEqualTo: widget.record['fundraiseId'])
          .get();
      _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();
      if (_Dataman.length == 0) {
        setState(() {
          _alreadySaved = "unsave";
        });
      } else {
        setState(() {
          _alreadySaved = "save";
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  //check if donated
  checkifdonated() async {
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

  //recent donation
  recentDonation() async {
    setState(() {
      isLoading = true;
    });
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('donations');

      CollectionReference _usercollectionRef =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await _collectionRef
          .where('fundraiseId', isEqualTo: widget.record['fundraiseId'])
          .get();
      _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();

      List<String> data = [];
      _Dataman.forEach((element) async {
        final ammount;
        final name;
        ammount = element['ammount'];
        QuerySnapshot querySnapshot = await _usercollectionRef
            .where('uid', isEqualTo: widget.record['uid'])
            .get();
        _Datauser = querySnapshot.docs.map((doc) => doc.data()).toList();
        final Name = _Datauser.map((e) => e['name']);
        data.add('$Name Donated $ammount');
        donors = data;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  save(id) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().savedFundraise(
        fundraiseId: id,
        uid: FirebaseAuth.instance.currentUser!.uid,
      );

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Saved!', context);
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

  //raised ammount
  raised() async {
    setState(() {
      isLoading = true;
    });
    try {
      double raised = 0;

      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('donations');

      QuerySnapshot querySnapshot = await _collectionRef
          .where('fundraiseId', isEqualTo: widget.record['fundraiseId'])
          .get();
      _Dataman = querySnapshot.docs.map((doc) => doc.data()).toList();

      _Dataman.forEach((element) {
        raised = raised + element['ammount'];
      });
      raisedammount = raised;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  unsave(id) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().unsavedFundraise(
        fundraiseId: id,
      );

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('UnSaved!', context);
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
          "Fund Raiser",
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          ActionButton2(
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Shared", // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.CENTER, // location
                  timeInSecForIosWeb: 1 // duration
                  );
            },
            icons: Icons.share,
          ),
          const SizedBox(width: 12),
          ActionButton2(
            onPressed: () {
              if (_alreadySaved == 'unsave') {
                setState(() {
                  _alreadySaved = "save";
                });
                save(widget.record["fundraiseId"]);
              } else {
                setState(() {
                  _alreadySaved = "unsave";
                });
                unsave(widget.record["fundraiseId"]);
              }
            },
            icons: (_alreadySaved == "save"
                ? Icons.bookmark
                : Icons.bookmark_border),
          ),
          const SizedBox(width: 12),
        ],
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            color:
                _opencontact == "close" ? null : Color.fromARGB(52, 0, 0, 0)),
        child: GestureDetector(
          onTap: () async {
            setState(() {
              _opencontact = 'close';
            });
          },
          child: Container(
            width: size.width,
            height: size.height - kToolbarHeight - 24,
            padding: const EdgeInsets.only(
                top: 0.0, bottom: 0.0, left: 8.0, right: 8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                    child: SingleFundraisersSlider(widget.record["images"]),
                  ),
                  const SizedBox(height: 12),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.record['title'],
                          textAlign: TextAlign.start,
                          style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Posted On: ${posteddate}',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.urbanist(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 123, 123, 123)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      child: LinearProgressIndicator(
                        value: (raisedammount / widget.record['goal']),
                        color: primaryColor,
                        backgroundColor: progressBackgroundColor,
                        minHeight: 5.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: RichText(
                      text: TextSpan(
                        text: raisedammount.toString(),
                        style: GoogleFonts.urbanist(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' fund raised from ',
                            style: GoogleFonts.urbanist(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: widget.record['goal'].toString(),
                            style: GoogleFonts.urbanist(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(top: 0.0),
                    child: RichText(
                      text: TextSpan(
                        text: "About Fund Raiser",
                        style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 2),
                      children: [
                        Text(
                          'Fund Raiser: ${widget.record["recipientName"]}',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.urbanist(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Raising For: ',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.urbanist(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Category: ${widget.record["category"]}',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.urbanist(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_opencontact == 'close') {
                          setState(() {
                            _opencontact = 'open';
                          });
                        } else {
                          setState(() {
                            _opencontact = 'close';
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'Contact',
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: RichText(
                      text: TextSpan(
                        // text: "\$${raisedAmount.toInt()}",
                        text: "Description:",
                        style: GoogleFonts.urbanist(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        widget.record["story"],
                        style: GoogleFonts.urbanist(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 135, 135, 135)),
                        maxLines: (_descseemore == "expand" ? null : 4),
                        overflow: (_descseemore == "expand"
                            ? null
                            : TextOverflow.ellipsis),
                      ),
                      TextButton(
                        child: Text(
                          (_descseemore == "expand"
                              ? '\n See Less'
                              : '\n See More'),
                          style: GoogleFonts.urbanist(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () => {
                          if (_descseemore == 'expand')
                            {
                              setState(() {
                                _descseemore = "notexpand";
                              })
                            }
                          else
                            {
                              setState(() {
                                _descseemore = "expand";
                              })
                            }
                        },
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Recent Donor:",
                        style: GoogleFonts.urbanist(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('donations')
                          .where('fundraiseId',
                              isEqualTo: widget.record['fundraiseId'])
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => RecentDonors(
                                Snap: snapshot.data!.docs[index].data()));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, top: 0.0),
                    alignment: Alignment.center,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                      child: Text(
                        'See More',
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                                //donate();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DonateScreen(widget.record)),
                                );
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
