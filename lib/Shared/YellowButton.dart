// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class YellowButton extends StatefulWidget {
  String text;
  YellowButton({super.key, required this.text});

  @override
  State<YellowButton> createState() => _YellowButtonState();
}

class _YellowButtonState extends State<YellowButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *.7,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFFFFF600),
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Center(
        child: Text(widget.text,
            style: TextStyle(
                fontSize: 21.0,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
