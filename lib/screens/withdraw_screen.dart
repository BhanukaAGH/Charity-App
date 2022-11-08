import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum PaymentOptions { paypal, google, apple, card }

class WithdrawScreen extends StatefulWidget {
  final String fundraiseId;
  const WithdrawScreen({super.key, required this.fundraiseId});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _controller = TextEditingController();
  PaymentOptions? _options = PaymentOptions.paypal;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: greyTextColor, width: 2),
      borderRadius: BorderRadius.circular(12),
    );

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
          'Withdraw Funds',
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Amount',
                        hintStyle: GoogleFonts.urbanist(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: borderColor,
                        ),
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 24),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const Divider(
                      height: 36,
                      color: borderColor,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Withdraw Method',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: darkTextColor,
                          ),
                        ),
                        Text(
                          'Add New Card',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: _options == PaymentOptions.paypal
                              ? primaryColor
                              : borderColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minLeadingWidth: 24,
                      leading: SvgPicture.asset(
                        'assets/paypal.svg',
                        width: 32,
                      ),
                      title: Text(
                        'Paypal',
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: Radio<PaymentOptions>(
                        value: PaymentOptions.paypal,
                        groupValue: _options,
                        activeColor: primaryColor,
                        onChanged: (PaymentOptions? value) {
                          setState(() {
                            _options = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: _options == PaymentOptions.google
                              ? primaryColor
                              : borderColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minLeadingWidth: 24,
                      leading: SvgPicture.asset(
                        'assets/google.svg',
                        width: 32,
                      ),
                      title: Text(
                        'Google Pay',
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: Radio<PaymentOptions>(
                        value: PaymentOptions.google,
                        groupValue: _options,
                        activeColor: primaryColor,
                        onChanged: (PaymentOptions? value) {
                          setState(() {
                            _options = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: _options == PaymentOptions.apple
                              ? primaryColor
                              : borderColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minLeadingWidth: 24,
                      leading: SvgPicture.asset(
                        'assets/apple.svg',
                        width: 32,
                      ),
                      title: Text(
                        'Apple Pay',
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: Radio<PaymentOptions>(
                        value: PaymentOptions.apple,
                        groupValue: _options,
                        activeColor: primaryColor,
                        onChanged: (PaymentOptions? value) {
                          setState(() {
                            _options = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Pay with Debit/Credit Card',
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: _options == PaymentOptions.card
                              ? primaryColor
                              : borderColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minLeadingWidth: 24,
                      leading: SvgPicture.asset(
                        'assets/card.svg',
                        width: 32,
                      ),
                      title: Text(
                        '.... .... .... .... 5642',
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: Radio<PaymentOptions>(
                        value: PaymentOptions.card,
                        groupValue: _options,
                        activeColor: primaryColor,
                        onChanged: (PaymentOptions? value) {
                          setState(() {
                            _options = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
