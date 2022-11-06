// ignore_for_file: use_build_context_synchronously, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/OrderModel.dart';
import '../../../Service/Database.dart';

class EditNameSettingPopup extends StatefulWidget {
  String name;

  String documentId;
  EditNameSettingPopup({required this.name, required this.documentId});
  @override
  _EditNameSettingPopupState createState() => _EditNameSettingPopupState();
}

class _EditNameSettingPopupState extends State<EditNameSettingPopup> {
  String? newName;
  int? newIndex;
  String? documentId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newName = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    final dartMode = Provider.of<Order>(context).dartMode;
    return Container(
      decoration: BoxDecoration(
        color: dartMode ? Colors.grey[800] : Colors.white,

        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Edit name",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: dartMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
             Divider(
              color: dartMode ? Colors.white : Colors.black,
              height: 4.0,
            ),
            const SizedBox(
              height: 35.0,
            ),
            TextFormField(
              initialValue: newName ?? '',
              onChanged: (val) {
                newName = val;
              },
              style: TextStyle(
                  color: dartMode ? Color.fromARGB(255, 196, 196, 196) :
                  Colors.grey[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
                  // decorationColor: Colors.white,
                  ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20,top: 35),

                //Label Text/////////////////////////////////////////////////////////
                labelText: 'Name',
                // labelText: Texts.PHONE_NUMBER_LOGIN,
                focusColor: Color.fromARGB(255, 147, 163, 0),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    color: dartMode ? Color.fromARGB(255, 190, 190, 190) :  Colors.grey[600]),
                /* hintStyle: TextStyle(
                                  color: Colors.orange[900]
                                  ) */
                ///////////////////////////////////////////////

                //when it's not selected////////////////////////////
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    borderSide:
                        BorderSide(color: dartMode ? Colors.white : Colors.black,
                    )),
                ////////////////////////////////

                ///when textfield is selected//////////////////////////
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.orange.shade200)),
                ////////////////////////////////////////
              ),
            ),
            const SizedBox(height: 35),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * .7,
                  height: 60,
                  decoration: BoxDecoration(
                    color: dartMode ? Colors.grey[700] :
                    Color.fromARGB(255, 238, 238, 238),
                    border: Border.all(width: 1, color: Color.fromARGB(255, 117, 117, 117)),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Center(
                    child: Text('Cancel',
                        style: TextStyle(
                            fontSize: 21.0,
                            color: dartMode ? Colors.grey[400] : 
 Color.fromARGB(255, 117, 117, 117),
                            fontWeight: FontWeight.w600)),
                  ),
                )
            ),
            const SizedBox(height: 10),
            InkWell(
                onTap: () async {
                  newName ??= widget.name;

                  await DatabaseService()
                      .updateUsername(newName.toString(), widget.documentId);

                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .7,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF600),
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Center(
                    child: Text('Update',
                        style: TextStyle(
                            fontSize: 21.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                )),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
