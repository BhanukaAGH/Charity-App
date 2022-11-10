import 'dart:ui';

import 'package:charity_app/screens/home_screen.dart';
import 'package:charity_app/screens/root_screen.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../providers/add_new_member_provider.dart';
import '../utils/colors.dart';

class CreateTeam extends StatefulWidget {
  List<User> MemberList;
  final String fundraiseId;
  CreateTeam({super.key, required this.MemberList, required this.fundraiseId});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  bool isLoading = false;
  List<Map> listUser = [];

  void createGroup(String uid, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    List<String> idList = [];
    widget.MemberList.forEach((element) {
      idList.add(element.uid);
    });

    // await AddNewMember().createGroup(uid, widget.fundraiseId, idList);
    idList.add(uid);
    await AddNewMember().updateFundraise(widget.fundraiseId, idList);
    setState(() {
      isLoading = false;
    });
    showSnackBar('Group created Successfully', context);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RootScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Create Group')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Selected Members',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: widget.MemberList.length,
                  itemBuilder: ((ctx, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.MemberList[index].photoUrl),
                                ),
                              ),
                              subtitle: Text(widget.MemberList[index].email),
                              title: Text(
                                widget.MemberList[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ));
                  })),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                disabledBackgroundColor: disabledButtonColor,
              ),
              onPressed: () {
                createGroup(user.uid, context);
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      'Crete Group',
                      style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
