import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/screens/home_screen.dart';
import 'package:charity_app/screens/my_donats_screen.dart';
import 'package:charity_app/screens/my_fundraises_screen.dart';
import 'package:charity_app/screens/notification_screen.dart';
import 'package:charity_app/screens/profile_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const MyDonationsScreen(),
  const NotificationScreen(),
  const MyFundraisesScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
