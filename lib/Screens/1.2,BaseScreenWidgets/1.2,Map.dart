// ignore_for_file: unused_import, must_be_immutable, unused_field, unnecessary_new, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:moovlah_user/Screens/1.2,BaseScreenWidgets/1.2.1,%20AddressDetails.dart';
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
  ArgumentCallback<LatLng>? onTap;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

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

  _handleTap(LatLng point) {
    setState(() {
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: const InfoWindow(
          title: 'Location is Set',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      );
      Provider.of<Order>(context, listen: false)
          .addSpecificLocationPosition(point, widget.index);
      setState(() {
        markers[const MarkerId('123')] = marker;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void whenAddInfoTapped() {
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
                  // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AddressDetail(index: widget.index),
                ),
              ),
            );
          });
    }

    return loading == true
        ? const Center(
            child: SpinKitCircle(
            color: Colors.black,
            size: 50.0,
          ))
        : Stack(
            children: [
              GoogleMap(
                markers: Set<Marker>.of(markers.values),
                mapType: MapType.normal,
                tiltGesturesEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  tilt: 0,
                  bearing: 0,
                  target: _initialPosition,
                  zoom: 17.00,
                ),
                onTap: _handleTap,
                onMapCreated: (GoogleMapController controller) {
                  widget.mapController.complete(controller);
                },
              ),
              Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      whenAddInfoTapped();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .7,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade800,
                            blurRadius: 105.0, //effect of softening the shadow
                            spreadRadius: 1.7, //effecet of extending the shadow
                            offset: const Offset(
                                0.0, //horizontal
                                0.0 //vertical
                                ),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('Add Adress Details',
                            style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
