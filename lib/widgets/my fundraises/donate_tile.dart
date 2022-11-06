import 'package:charity_app/screens/chat_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonateTile extends StatefulWidget {
  final String uid;
  final double amount;

  const DonateTile({
    super.key,
    required this.uid,
    required this.amount,
  });

  @override
  State<DonateTile> createState() => _DonateTileState();
}

class _DonateTileState extends State<DonateTile> {
  String? imgUrl;
  String name = '';

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  _getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    final userData = snap.data() as Map<String, dynamic>;

    setState(() {
      imgUrl = userData['photoUrl'];
      name = userData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5.5,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            width: 1,
            color: borderColor,
          ),
        ),
        selected: true,
        leading: imgUrl != null
            ? CircleAvatar(
                maxRadius: 24,
                backgroundColor: borderColor,
                backgroundImage: NetworkImage(
                  imgUrl!,
                ),
              )
            : null,
        title: RichText(
          text: TextSpan(
            text: name,
            style: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: ' has donated ',
                style: GoogleFonts.urbanist(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: greyTextColor,
                ),
              ),
              TextSpan(
                text: '\$${widget.amount.toInt()}',
                style: GoogleFonts.urbanist(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        trailing: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  imgUrl: imgUrl!,
                  name: name,
                  price: widget.amount,
                ),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 2.5,
              color: primaryColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            'Say Thanks',
            style: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
