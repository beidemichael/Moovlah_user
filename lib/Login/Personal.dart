import 'package:flutter/material.dart';

import '../Shared/YellowButton.dart';
class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create A Personal Account',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          // phoneNumber = val;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 30, bottom: 10),
                        labelText: 'Username',
                        focusColor: Colors.orange[900],
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                            color: Colors.grey[800]),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.orange.shade200)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          // phoneNumber = val;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 30, bottom: 10),
                        labelText: 'Phone Number',
                        focusColor: Colors.orange[900],
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                            color: Colors.grey[800]),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.orange.shade200)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          // phoneNumber = val;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 30, bottom: 10),
                        labelText: 'Email',
                        focusColor: Colors.orange[900],
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                            color: Colors.grey[800]),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.orange.shade200)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          // phoneNumber = val;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 30, bottom: 10),
                        labelText: 'Password',
                        focusColor: Colors.orange[900],
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                            color: Colors.grey[800]),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.orange.shade200)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                
                  SizedBox(
                    height: 100,
                  ),
                  YellowButton(text: 'Next')
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}