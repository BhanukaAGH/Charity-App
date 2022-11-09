import 'dart:typed_data';
import '../providers/add_new_member_provider.dart';
import 'package:charity_app/screens/create_group_scree.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';

class CreateGroup extends StatefulWidget {
  final String fundraiserId;

  const CreateGroup({super.key, required this.fundraiserId});
  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  bool isComplete = false;
  bool isLoading = true;
  List<String> numbers = [];

  List<String> membersIdList = [];
  // void createTeam(String leaderId) async {
  List<Map> listUser = [];

  List<User> users = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getUser();
    super.didChangeDependencies();
  }

  void addMember() {
    setState(() {
      isComplete = !isComplete;
    });
  }

  void selectedCard(int index) {
    if (numbers.contains(index.toString())) {
      numbers.remove(index.toString());
      setState(() {});
      return;
    } else {
      numbers.add(index.toString());
      setState(() {});
      return;
    }
  }

  bool changeColor(int index) {
    return numbers.contains(index.toString());
  }

  void goToNextScreen() {
    membersIdList.forEach((element) {
      listUser.forEach((user) {
        if (user['uid'] == element) {
          users.add(User(
              uid: user['uid'],
              name: user['name'],
              email: user['email'],
              role: user['role'],
              photoUrl: user['photoUrl']));
          return;
        }
      });
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CreateTeam(MemberList: users, fundraiseId: widget.fundraiserId),
      ),
    );
  }

  void getUser() async {
    AddNewMember addNewMember =
        Provider.of<AddNewMember>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    var allUserList = await addNewMember.getAllUsers();
    allUserList.forEach(
      (element) {
        if (element['uid'] != user.uid) {
          listUser.add(element);
        }
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  void getMemberIds(String uid) {
    if (membersIdList.contains(uid)) {
      membersIdList.remove(uid);
    } else {
      membersIdList.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Members To The Group')),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Available Users',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 500,
                    child: ListView.builder(
                        itemCount: listUser.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Card(
                                color: changeColor(index) == true
                                    ? secondaryColor
                                    : null,
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
                                            listUser[index]['photoUrl']),
                                      ),
                                    ),
                                    title: Text(listUser[index]['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(listUser[index]['email']),
                                    trailing: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        disabledBackgroundColor:
                                            disabledButtonColor,
                                      ),
                                      onPressed: () {
                                        selectedCard(index);
                                        getMemberIds(listUser[index]['uid']);
                                      },
                                      child: Text(
                                        changeColor(index) == true
                                            ? 'Remove'
                                            : 'Add',
                                        style: GoogleFonts.urbanist(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        })),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      disabledBackgroundColor: disabledButtonColor,
                    ),
                    onPressed: membersIdList.isEmpty == true ? null : addMember,
                    child: Text(
                      'Finish add Members',
                      style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      disabledBackgroundColor: disabledButtonColor,
                    ),
                    onPressed: isComplete == true ? goToNextScreen : null,
                    child: Text(
                      'Next',
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
