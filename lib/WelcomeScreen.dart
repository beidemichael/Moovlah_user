import 'package:flutter/material.dart';
import 'package:moovlah_user/Shared/YellowButton.dart';

import 'Login/LoginPage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/Welcome.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    child: YellowButton(text: 'Login'))),
          ],
        )
      ],
    );
  }
}
