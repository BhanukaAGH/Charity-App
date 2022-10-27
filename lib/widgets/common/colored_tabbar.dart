import 'package:flutter/material.dart';

class ColoredTabBar extends Container implements PreferredSizeWidget {
  final Color tabcolor;
  final TabBar tabBar;

  ColoredTabBar({super.key, required this.tabcolor, required this.tabBar});

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: tabcolor,
        child: tabBar,
      );
}
