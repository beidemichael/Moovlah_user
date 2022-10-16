// ignore_for_file: unused_import, must_be_immutable, unused_field, unnecessary_new, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:moovlah_user/Shared/YellowButton.dart';
import 'package:provider/provider.dart';

import '../../Models/OrderModel.dart';
import '../../Models/models.dart';

class MapForLocation extends StatefulWidget {
  Completer<GoogleMapController> mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  int index;
  MapForLocation(
      {super.key,
      required this.cameraPosition,
      required this.mapController,
      required this.index});

  @override
  State<MapForLocation> createState() => _MapForLocationState();
}

class _MapForLocationState extends State<MapForLocation> {
  late LatLng _initialPosition;
  bool loading = false;
  String phoneCode = "+65";
  String phoneNumber = "";
  String contactName = "";
  String floorAndUnitNumber = "";

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    setState(() {
      loading = true;
    });
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    _initialPosition =
        LatLng(_locationData.latitude!, _locationData.longitude!);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      phoneCode = countryCode.toString();
    });

    print("New Country selected: " + countryCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    String locationListDescription =
        Provider.of<Order>(context).locationDescription(widget.index);
        
    final locationInput = Provider.of<Order>(context).locationInputDisplay;
    return 
    loading == true
        ? const Center(
            child: SpinKitCircle(
            color: Colors.black,
            size: 50.0,
          ))
        : 
        Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                tiltGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  tilt: 0,
                  bearing: 0,
                  target: _initialPosition,
                  zoom: 17.00,
                ),
                onMapCreated: (GoogleMapController controller) {
                  widget.mapController.complete(controller);
                },
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 1.0, //effect of softening the shadow
                        spreadRadius: 0.1, //effecet of extending the shadow
                        offset: const Offset(
                            0.0, //horizontal
                            -1.0 //vertical
                            ),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Adress Details',
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
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
                                            phoneNumber =
                                                phoneCode + val.trim();
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
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
                            : 
                        locationListDescription != ''
                                ?GestureDetector(
                            onTap: () {
                              if (locationListDescription != '') {
                                Provider.of<Order>(context, listen: false)
                                    .addLocationInfo(phoneNumber, contactName,
                                        floorAndUnitNumber, widget.index);
                                Navigator.of(context).pop();
                              }
                            },
                            child:  YellowButton(text: 'Confirm')
                                ):Container(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
