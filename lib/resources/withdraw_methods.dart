import 'dart:convert';

import 'package:charity_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WithdrawMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? paymentIntent;

  //! Make Payment
  void makePayment(
    BuildContext context,
    String amount,
    String currency,
  ) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).getUser;
      paymentIntent = await createPaymentIntent(context, amount, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: user.name,
          customerId: _auth.currentUser!.uid,
        ),
      );

      //! Payment Success Code
      await Stripe.instance.presentPaymentSheet().then((value) {
        Fluttertoast.showToast(
          msg: 'Payment Successfull',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        paymentIntent = null;
      });

      //! Payment Failed Code
    } on StripeException catch (e) {
      Fluttertoast.showToast(
        msg: 'Payment Cancelled',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  //! Create Payment Intent
  createPaymentIntent(
    BuildContext context,
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
            'Content-Type': 'application/x-www-form-urlencoded',
          });

      return jsonDecode(response.body);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  //! Convert Cent to Actual Value
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  //! Create Customer
  createCustomer() async {}
}
