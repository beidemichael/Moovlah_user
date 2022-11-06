// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/OrderModel.dart';
class Drivers extends StatefulWidget {
  const Drivers({super.key});

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  @override
  Widget build(BuildContext context) {
    final dartMode = Provider.of<Order>(context).dartMode;
    return Scaffold(
      backgroundColor: dartMode ? Colors.grey[800] : Colors.grey[50],
      appBar: AppBar(
        
          centerTitle: true,
          backgroundColor: dartMode ? Colors.grey[800] : Colors.grey[50],
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text('Drivers',
                  style: TextStyle(
                      fontSize: 21.0,
                      color: dartMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Container(),
    );
  }
}