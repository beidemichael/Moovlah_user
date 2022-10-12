// ignore_for_file: file_names, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/OrderModel.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text('Select your account type',
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 10,
                ),
                const Text('What type of delivery do you need',
                    style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w100)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Order>(context, listen: false)
                        .changeScreen('personal');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 165,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Personal',
                              style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          Image.asset(
                            'assets/undraw_mobile_user_re_xta4.png',
                            height: 120,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Order>(context, listen: false)
                        .changeScreen('business');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 165,
                        // ignore: sort_child_properties_last
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/undraw_business_chat_re_gg4h.png',
                              height: 120,
                            ),
                            const Text('Business',
                                style: TextStyle(
                                    fontSize: 21.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TextStyle(
                            fontSize: 19.0,
                            color: Color.fromARGB(255, 92, 92, 92),
                            fontWeight: FontWeight.w400)),
                    GestureDetector(
                      onTap: () {
                        Provider.of<Order>(context, listen: false)
                            .changeScreen('login');
                      },
                      child: const Text('Login',
                          style: TextStyle(
                              fontSize: 19.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                    ),
                    const Text(' here.',
                        style: TextStyle(
                            fontSize: 19.0,
                            color: Color.fromARGB(255, 92, 92, 92),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
