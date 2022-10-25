import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icons;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Handle your callback
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        child: Ink(
          width: 42,
          decoration: const BoxDecoration(
            color: lightPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Icon(icons, color: primaryColor),
        ),
      ),
    );
  }
}
