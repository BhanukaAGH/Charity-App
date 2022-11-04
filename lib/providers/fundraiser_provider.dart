import 'package:charity_app/models/fundraise.dart';
import 'package:charity_app/models/user.dart';
import 'package:charity_app/resources/auth_methods.dart';
import 'package:charity_app/resources/fundraiser_methods.dart';
import 'package:flutter/material.dart';

class FundraiseProvider with ChangeNotifier {
  List<Fundraise>? _fundraises;
  final FundraiserMethods _fundraiserMethods = FundraiserMethods();

  List<Fundraise?> get getFundraisers => _fundraises!;

  // Future<void> refreshUser() async {
  //   List<Fundraise> fundraisers = await _fundraiserMethods.getFundraisers();
  //   _fundraises = fundraises;
  //   notifyListeners();
  // }
}
