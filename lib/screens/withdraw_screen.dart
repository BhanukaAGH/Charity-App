import 'package:charity_app/resources/withdraw_methods.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  void withdrawPayment(BuildContext context) async {
    WithdrawMethods().makePayment(context, _controller.text, 'LKR');
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: borderColor, width: 2),
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
                    Text(
                      'Select Withdraw Method',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: darkTextColor,
                      ),
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
                        'Visa / Master Card',
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
              onPressed: () {
                if (_controller.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'Please enter amount',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                } else if (int.parse(_controller.text) < 1000) {
                  Fluttertoast.showToast(
                    msg: 'Please enter amount greter than 1000.',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                } else {
                  withdrawPayment(context);
                }
              },
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
