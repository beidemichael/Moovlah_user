import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Screens/Drivers.dart';
import 'Screens/Help.dart';
import 'Screens/Orders.dart';
import 'Screens/Setting.dart';

class DrawerContent extends StatefulWidget {
  const DrawerContent({super.key});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(55.0),
          bottomRight: Radius.circular(55.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
              height: 150,
              width: 150,
              child:  Icon(
                FontAwesomeIcons.userLarge,
                shadows: [
                  BoxShadow(
                    color: Colors.grey.shade900,
                    blurRadius: 2.0, //effect of softening the shadow
                    spreadRadius: 1, //effecet of extending the shadow
                    offset: Offset(
                        0.0, //horizontal
                        1.0 //vertical
                        ),
                  ),
                ],
                size: 80.0,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFFF600),
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(100),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:30.0),
                  child: const Text('Name',
                      style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Orders()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.boxOpen,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey.shade900,
                              blurRadius: 2.0, //effect of softening the shadow
                              spreadRadius: 1, //effecet of extending the shadow
                              offset: Offset(
                                  0.0, //horizontal
                                  0.0 //vertical
                                  ),
                            ),
                          ],
                          size: 25.0,
                          color: Color(0xFFFFF600),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        const Text('Orders',
                            style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Drivers()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.car,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey.shade900,
                              blurRadius: 2.0, //effect of softening the shadow
                              spreadRadius: 1, //effecet of extending the shadow
                              offset: Offset(
                                  0.0, //horizontal
                                  0.0 //vertical
                                  ),
                            ),
                          ],
                          size: 25.0,
                          color: Color(0xFFFFF600),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        const Text('Drivers',
                            style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Help()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.phone,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey.shade900,
                              blurRadius: 2.0, //effect of softening the shadow
                              spreadRadius: 1, //effecet of extending the shadow
                              offset: Offset(
                                  0.0, //horizontal
                                  0.0 //vertical
                                  ),
                            ),
                          ],
                          size: 25.0,
                          color: Color(0xFFFFF600),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        const Text('Help',
                            style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Setting()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.wrench,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey.shade900,
                              blurRadius: 2.0, //effect of softening the shadow
                              spreadRadius: 1, //effecet of extending the shadow
                              offset: Offset(
                                  0.0, //horizontal
                                  0.0 //vertical
                                  ),
                            ),
                          ],
                          size: 25.0,
                          color: Color(0xFFFFF600),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        const Text('Setting',
                            style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
