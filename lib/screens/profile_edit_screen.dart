// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//ProfileEditScreen
//_ProfileEditScreenState
import 'dart:typed_data';

import 'package:charity_app/resources/firestore_methods.dart';
import 'package:charity_app/resources/storage_methods.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/colors.dart';
import '../widgets/common/form_field_input.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _userFormKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  Uint8List? image;
  bool _isLoading = false;
  bool isLoading = false;

  var userData = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = userSnap.data()!;
      print('][][][][][PHOTOURL');
      print(userData['photoUrl']);
      print(userData['name']);

      _nameController = TextEditingController(text: userData['name']);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  //select img
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Add Profile Image',
            textAlign: TextAlign.center,
          ),
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    semanticLabel: 'Camera',
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.collections_outlined,
                    semanticLabel: 'Gallery',
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
              ],
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  update() async {
    setState(() {
      isLoading = true;
    });
    try {
      final isUserFormValid = _userFormKey.currentState!.validate();
      if (!isUserFormValid) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      if (_file == null) {
        String res = await FirestoreMethods().updateUser(
            uid: FirebaseAuth.instance.currentUser!.uid,
            name: _nameController.text,
            photoUrl: userData['photoUrl'],
            email: userData['email']);

        if (res == 'success') {
          showSnackBar('Updated!', context);
        } else {
          showSnackBar('Error', context);
        }
        setState(() {
          isLoading = false;
        });
      } else {
        String imageUrl =
            await StorageMethods().uploadUserImageToStorage('users', _file);
        print("imageUrl");
        print(imageUrl.length);
        if (imageUrl.length != 0) {
          String res = await FirestoreMethods().updateUser(
              uid: FirebaseAuth.instance.currentUser!.uid,
              name: _nameController.text,
              photoUrl: imageUrl,
              email: userData['email']);

          if (res == 'success') {
            showSnackBar('Updated!', context);
          } else {
            showSnackBar('Error', context);
          }
        }
        setState(() {
          isLoading = false;
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
    print("photoUrl");
    print(userData['photoUrl']);
    var size = MediaQuery.of(context).size;
    return _isLoading
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                'Edit Profile',
                style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.grey.shade50,
              centerTitle: true,
            ),
            body: Container(
              width: size.width,
              height: size.height - kToolbarHeight - 24,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        _file != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_file!),
                              )
                            : CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(userData[
                                        'photoUrl'] ??
                                    'https://st.depositphotos.com/1052233/2815/v/600/depositphotos_28158459-stock-illustration-male-default-profile-picture.jpg'),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: () => _selectImage(context),
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(height: 12),
                    const Divider(
                      thickness: 0.8,
                      color: borderColor,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'User Details',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Form(
                      key: _userFormKey,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 2),
                        children: [
                          FormFieldInput(
                            controller: _nameController,
                            label: 'Name',
                            hintText: 'Name',
                            withAsterisk: true,
                            textInputType: TextInputType.name,
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
              child: Container(
                height: 64,
                padding: const EdgeInsets.only(bottom: 4),
                alignment: Alignment.center,
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: borderColor,
                    ),
                  ),
                  child: SizedBox(
                    width: size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: isLoading ? 4 : 12),
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          disabledBackgroundColor: disabledButtonColor,
                        ),
                        onPressed: () {
                          update();
                        },
                        child: isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                'Save',
                                style: GoogleFonts.urbanist(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
