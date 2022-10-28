import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateFundraiseScreen extends StatefulWidget {
  const CreateFundraiseScreen({super.key});

  @override
  State<CreateFundraiseScreen> createState() => _CreateFundraiseScreenState();
}

class _CreateFundraiseScreenState extends State<CreateFundraiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Create New Fundraise',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
