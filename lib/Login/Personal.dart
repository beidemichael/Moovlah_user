// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moovlah_user/Service/auth.dart';
import '../Shared/YellowButton.dart';

class Personal extends StatefulWidget {
  Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? userName;
  String? phoneNumber;
  String? email;
  String? password;
  bool isLoading = false;
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Create A Personal Account',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          userName = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.orange.shade200)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
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
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.orange.shade200)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.orange.shade200)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color.fromARGB(255, 190, 184, 0),
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
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
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.orange.shade200)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          await AuthServices.signUpEmailAndPassword(
                            context: context,
                            emailAddress: email!,
                            password: password!,
                            type: 'personal',
                            phoneNumber: phoneNumber!,
                            userName: userName!,
                            businessName: ''
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const Center(
                              child: SpinKitCircle(
                              color: Colors.black,
                              size: 50.0,
                            ))
                          : YellowButton(text: 'Next'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
