// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moovlah_user/Service/auth.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Setting',
                  style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black)),
      body: GestureDetector(
        onTap: () {
          AuthServices.signOut();
          Navigator.of(context).pop();
        },
        child: Center(
          child: Container(color: Colors.red, child: Text('SignOut')),
        ),
      ),
    );
  }
}
