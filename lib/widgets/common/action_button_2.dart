import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ActionButton2 extends StatelessWidget {
  final Function()? onPressed;
  final IconData icons;

  const ActionButton2({
    super.key,
    required this.onPressed,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Handle your callback
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Ink(
          width: 35,
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Icon(icons, color: Colors.white,size: 20.0,),
        ),
      ),
    );
  }
}
