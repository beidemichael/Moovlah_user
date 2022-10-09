import 'package:flutter/material.dart';
import 'package:moovlah_user/Models/OrderModel.dart';
import 'package:provider/provider.dart';

import '../Shared/YellowButton.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _formKey = GlobalKey<FormState>();
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/moovlah_logo_Singapore2022_5.png', width: 60),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    'Order Remarks',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 21.0,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: TextFormField(
                  validator: (val) =>
                      val!.length != 6 ? 'Code should be 6 digits long' : null,
                  textAlign: TextAlign.left,
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                  maxLength: 500,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    hintText:
                        'Add any important instructions about your delivery',
                    hintMaxLines: 3,
                    hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                    focusColor: Colors.purple[900],
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.purple[400]!)),
                    errorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.purple[400]!)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.purple[400]!)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: GestureDetector(
                    onTap: () {
                      Provider.of<Order>(context, listen: false)
                          .addNote(description);
                      Navigator.of(context).pop();
                    },
                    child: YellowButton(text: 'Add')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
