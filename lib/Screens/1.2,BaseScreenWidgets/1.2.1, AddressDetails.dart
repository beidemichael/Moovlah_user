import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../Models/OrderModel.dart';
import '../../Shared/YellowButton.dart';

class AddressDetail extends StatefulWidget {
  int index;
  AddressDetail({super.key, required this.index});

  @override
  State<AddressDetail> createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  String phoneCode = "+65";
  String phoneNumber = "";
  String contactName = "";
  String floorAndUnitNumber = "";
  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      phoneCode = countryCode.toString();
    });

    print("New Country selected: " + countryCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    final locationInput = Provider.of<Order>(context).locationInputDisplay;
    String locationListDescription =
        Provider.of<Order>(context).locationDescription(widget.index);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('Address Details',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: _onCountryChange,
                            initialSelection: '+65',
                            favorite: ['+65', 'SG'],
                            textStyle: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15.0,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                phoneNumber = phoneCode + val.trim();
                                // widget.location.phoneNumber =
                                //     phoneCode + phoneNumber.trim();
                              });
                            },
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Enter Phone Number',
                              focusColor: Colors.orange[900],
                              labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 30),
                        Expanded(
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                contactName = val;
                                // widget.location.contactName = val;
                              });
                            },
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Contact Name',
                              focusColor: Colors.orange[900],
                              labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 30),
                        Expanded(
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                floorAndUnitNumber = val;
                                // widget.location.floorAndUnitNumber =
                                //     val;
                              });
                            },
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Floor and Unit Number',
                              focusColor: Colors.orange[900],
                              labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            locationInput == true
                ? const SpinKitCircle(
                    color: Colors.black,
                  )
                : locationListDescription != ''
                    ? GestureDetector(
                        onTap: () {
                          if (locationListDescription != '') {
                            Provider.of<Order>(context, listen: false)
                                .addLocationInfo(phoneNumber, contactName,
                                    floorAndUnitNumber, widget.index);
                            Navigator.of(context).pop();
                           
                          }
                        },
                        child: YellowButton(text: 'Confirm'))
                    : Container(),
          ],
        ),
      ),
    );
  }
}
