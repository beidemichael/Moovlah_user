// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:moovlah_user/Shared/YellowButton.dart';
import 'package:provider/provider.dart';
import '../Models/OrderModel.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/Welcome.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .85,
            ),
            Container(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      Provider.of<Order>(context, listen: false)
                          .changeScreen('login');
                    },
                    child: YellowButton(text: 'Login'))),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                Provider.of<Order>(context, listen: false)
                    .changeScreen('signup');
              },
              child: const Text('SignUp',
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        )
      ],
    );
  }
}
