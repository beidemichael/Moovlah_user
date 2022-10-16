// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Models/OrderModel.dart';
import '../Models/models.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount, required String currency,
     required  BuildContext context,
     required UserInformation userInfo}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          // applePay: true,
          // googlePay: true,
          // testEnv: true,
          // merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          style: ThemeMode.light,
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Color.fromARGB(255, 253, 253, 253),
              primary: Color(0xFFFFF600),
              // componentBorder: Color.fromARGB(255, 187, 187, 187),
              componentBackground: Color.fromARGB(255, 255, 255, 255),
              componentText: Color.fromARGB(255, 189, 189, 189),
              primaryText: Color.fromARGB(255, 0, 0, 0),
              secondaryText: Color.fromARGB(255, 78, 78, 78),
              placeholderText: Color.fromARGB(255, 128, 128, 128),
            ),
            shapes: PaymentSheetShape(
              borderWidth: 1,
              borderRadius: 15,
              shadow: PaymentSheetShadowParams(color: Colors.red),
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
              colors: PaymentSheetPrimaryButtonTheme(
                dark: PaymentSheetPrimaryButtonThemeColors(
                  background: Color.fromARGB(255, 231, 235, 30),
                  text: Color.fromARGB(255, 0, 0, 0),
                  border: Color.fromARGB(255, 0, 0, 0),
                ),
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: Color.fromARGB(255, 231, 235, 30),
                  text: Color.fromARGB(255, 0, 0, 0),
                  border: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ));
        displayPaymentSheet(context, userInfo);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context, UserInformation userInfo) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // Get.snackbar('Payment', 'Payment Successful',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //     margin: const EdgeInsets.all(10),
      //     duration: const Duration(seconds: 2));
       Provider.of<Order>(context, listen: false)
          .publishOrder(context, userInfo);
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: $e");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
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
            'Authorization':
                'Bearer sk_test_51LrDO4Gi9PXHjIudNjj7bTdr6HZ7fqkeIJMy8rPZI1IJsW7rCWuSS64pfZRY0Gxoz1sp99BOISUBLUc0JWRvZNSw00DUVXJbe2',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
          print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
