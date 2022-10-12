// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moovlah_user/Login/LogIn.dart';
import 'package:moovlah_user/Login/SignUp.dart';
import 'package:provider/provider.dart';

import '../Models/OrderModel.dart';
import 'Business.dart';

import 'Personal.dart';
import 'WelcomeScreen.dart';


class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({super.key});

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<Order>(context).screenDisplay;

    return screen == 'welcome'
        ? WelcomePage()
        : screen == 'signup'
            ? SignUpPage()
            : screen == 'personal'
                ? Personal()
                : screen == 'business'
                    ? Business()
                    : screen == 'login'
                        ? LogIn()
                    : Container();
  }
}
