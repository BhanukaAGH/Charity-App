import 'dart:ui';

import 'package:charity_app/screens/home_screen.dart';
import 'package:charity_app/screens/root_screen.dart';
import 'package:charity_app/screens/team_fundraise_screen.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:charity_app/widgets/my%20fundraises/team_fundraise_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../providers/add_new_member_provider.dart';
import '../utils/colors.dart';

class ViewGroupMembers extends StatefulWidget {
  List<dynamic> MemberList;
  String fundraiseId;
  String createdId;

  ViewGroupMembers(
      {super.key,
      required this.MemberList,
      required this.fundraiseId,
      required this.createdId});

  @override
  State<ViewGroupMembers> createState() => _ViewGroupMembersState();
}

class _ViewGroupMembersState extends State<ViewGroupMembers> {
  bool isLoading = false;
  List<Map> listUser = [];
  List<Map> members = [];
  var isLeader;

  @override
  void didChangeDependencies() {
    fetchGroupMembers();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void fetchGroupMembers() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String userId = _auth.currentUser!.uid;
    if (widget.MemberList.contains(userId)) {
      widget.MemberList.remove(userId);
    }
    listUser = await AddNewMember().getAllUsers();
    listUser.forEach((element) {
      if (widget.MemberList.contains(element['uid'])) {
        members.add(element);
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  bool checkLeader() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser!.uid == widget.createdId) {
      return true;
    } else {
      return false;
    }
  }

  void deleteUser(int index, String uid, BuildContext context) {
    var removeUser;
    List<String> newMembersList = [];
    showDialog(
        context: context,
        builder: ((c) => AlertDialog(
              title: const Text('Are You Sure'),
              content: const Text(
                  'Do you want to remove this member from the group'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(c).pop(true);
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.of(c).pop(false);
                    },
                    child: const Text('No'))
              ],
            ))).then((value) {
      if (value) {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        String userId = _auth.currentUser!.uid;
        newMembersList.add(userId);
        members.forEach((el) {
          if (el['uid'] == uid) {
            removeUser = el;
          }
        });
        members.remove(removeUser);
        members.map(
          (e) {
            newMembersList.add(e['uid']);
          },
        ).toList();
        AddNewMember().deleteMember(widget.fundraiseId, newMembersList);
        showSnackBar('Member deleted', context);
        setState(() {});
        return;
      } else {
        return;
      }
    });
  }

  // void fundraiseScreen(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const TeamFundraiseScreen(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Group Members')),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                        itemCount: members.length,
                        itemBuilder: ((ctx, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Card(
                                color: Color.fromARGB(255, 232, 234, 237),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            members[index]['photoUrl']),
                                      ),
                                    ),
                                    title: Text(
                                      members[index]['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(members[index]['email']),
                                    trailing: checkLeader() == true
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              deleteUser(index,
                                                  members[index]['uid'], ctx);
                                            },
                                          )
                                        : null,
                                  ),
                                ),
                              ));
                        })),
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 16, vertical: 8),
                  //     backgroundColor: primaryColor,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(24),
                  //     ),
                  //     disabledBackgroundColor: disabledButtonColor,
                  //   ),
                  //   onPressed: () {
                  //     fundraiseScreen(context);
                  //   },
                  //   child: isLoading
                  //       ? const CircularProgressIndicator()
                  //       : Text(
                  //           'Back to Fundraise',
                  //           style: GoogleFonts.urbanist(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.white),
                  //         ),
                  // )
                ],
              ),
            ),
    );
  }
}
