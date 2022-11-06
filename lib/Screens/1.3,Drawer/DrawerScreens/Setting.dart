// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moovlah_user/Service/auth.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../Models/OrderModel.dart';
import '../../../Models/models.dart';
import '../../../Service/Database.dart';
import 'edit_Name_popup.dart';

class Setting extends StatefulWidget {
  Setting({
    super.key,
  });

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    final dartMode = Provider.of<Order>(context).dartMode;
    void whenProfileUpDateTapped() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: FractionallySizedBox(
                heightFactor: 0.6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: EditNameSettingPopup(
                      name: userInfo[0].userName,
                      documentId: userInfo[0].documentId),
                ),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: dartMode ? Colors.grey[800] : Colors.grey[50],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: dartMode ? Colors.grey[800] : Colors.grey[50],
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text('Setting',
                  style: TextStyle(
                      fontSize: 21.0,
                      color: dartMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black)),
      // ignore: unnecessary_null_comparison
      body: userInfo == null || userInfo.length == 0
          ?  Center(
              child: SpinKitCircle(
              color: dartMode ? Colors.white : Colors.black,
              size: 50.0,
            ))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF600),
                        border: Border.all(width: 1, color: dartMode ? Colors.white : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        FontAwesomeIcons.userLarge,
                        shadows: [
                          BoxShadow(
                            color: Colors.grey.shade800,
                            blurRadius: 2.0, //effect of softening the shadow
                            spreadRadius: 1, //effecet of extending the shadow
                            offset: const Offset(
                                0.0, //horizontal
                                1.0 //vertical
                                ),
                          ),
                        ],
                        size: 80.0,
                        color: Colors.white,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Text(userInfo[0].userName,
                        style:  TextStyle(
                            fontSize: 35.0,
                            color: dartMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      whenProfileUpDateTapped();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: dartMode ? Colors.grey[800] : Colors.white,
                        border: Border.all(
                            width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.userPen,
                              size: 20.0,
                              color: dartMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                             Text(
                              'Change Username',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                  color: dartMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      // AuthServices.signOut();
                      // Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color:  dartMode ? Colors.grey[800] : Colors.white,
                        border: Border.all(
                            width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.camera,
                                  size: 20.0,
                                  color: dartMode ? Colors.white : Colors.black,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                 Text(
                                  'Proof of Delivery',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0,
                                      color: dartMode ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              // This bool value toggles the switch.
                              value: userInfo[0].proofOfDelivery,
                              activeColor: Color.fromARGB(255, 199, 179, 0),
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  DatabaseService().updateProofOfDelivery(
                                      userInfo[0].proofOfDelivery,
                                      userInfo[0].userUid);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      AuthServices.signOut();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color:  dartMode ? Colors.grey[800] : Colors.white,
                        border: Border.all(
                            width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.doorOpen,
                              size: 20.0,
                              color: dartMode ?Colors.white:Colors.black,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                             Text(
                              'SignOut',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                  color: dartMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
