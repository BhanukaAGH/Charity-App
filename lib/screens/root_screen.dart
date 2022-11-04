import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charity_app/providers/user_provider.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/utils/global_variables.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    addData();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: primaryColor,
        inactiveColor: unselectedIconColor,
        currentIndex: _page,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Donations',
            icon: Icon(Icons.volunteer_activism),
          ),
          BottomNavigationBarItem(
            label: 'Notifications',
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            label: 'Fundraisers',
            icon: Icon(Icons.ballot_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
