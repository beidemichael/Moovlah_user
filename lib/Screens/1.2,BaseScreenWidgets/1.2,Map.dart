// ignore_for_file: unused_import, must_be_immutable, unused_field, unnecessary_new, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:moovlah_user/Screens/1.2,BaseScreenWidgets/1.2.1,%20AddressDetails.dart';
import 'package:moovlah_user/Shared/YellowButton.dart';
import 'package:provider/provider.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../Models/OrderModel.dart';
import '../../Models/models.dart';

class MapForLocation extends StatefulWidget {
  Completer<GoogleMapController> mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  int index;
  bool loading;
  var initialPosition;
  MapForLocation({
    super.key,
    required this.cameraPosition,
    required this.mapController,
    required this.index,
    required this.initialPosition,
    required this.loading,
  });

  @override
  State<MapForLocation> createState() => _MapForLocationState();
}

class _MapForLocationState extends State<MapForLocation> {
  ArgumentCallback<LatLng>? onTap;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  bool bottomSheetExpanded = false;
  bool top = false;
  CameraPosition position2 = CameraPosition(target: const LatLng(0, 0));

  void _onCameraMove(CameraPosition position) {
    position2 = position;
  }

  _updateAdress() async {
    if (position2.target.latitude != 0) {
      Provider.of<Order>(context, listen: false)
          .addSpecificLocationPosition(position2.target, widget.index);
      var fetchGeocoder = await Geocoder2.getDataFromCoordinates(
          latitude: position2.target.latitude,
          longitude: position2.target.longitude,
          googleMapApiKey: "AIzaSyDC8eK2_tywqgCtS8kLaOdrjs61aMVP1hI");
      Provider.of<Order>(context, listen: false).addLocationPosition(
          fetchGeocoder.address, position2.target, widget.index);
      print('New map address: ' + fetchGeocoder.address);
    }
  }

  // _handleTap(LatLng point) {
  //   setState(() {
  //     // creating a new MARKER
  //     final Marker marker = Marker(
  //       markerId: MarkerId(point.toString()),
  //       position: point,
  //       infoWindow: const InfoWindow(
  //         title: 'Location is Set',
  //       ),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
  //     );
  //     Provider.of<Order>(context, listen: false)
  //         .addSpecificLocationPosition(point, widget.index);
  //     setState(() {
  //       markers[const MarkerId('123')] = marker;
  //     });
  //     key.currentState!.expand();
  //   });
  // }
  Future<void> initialAnimateCamera() async {
    final GoogleMapController controller = await widget.mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: widget.initialPosition, zoom: 17)));
  }

  @override
  Widget build(BuildContext context) {
    final LocationListSpecific =
        Provider.of<Order>(context).locationList[widget.index];

    return widget.loading == true
        ? const Center(
            child: SpinKitCircle(
            color: Colors.black,
            size: 50.0,
          ))
        : Container(
            color: Colors.white,
            child: Center(
              child: Stack(
                children: [
                  GoogleMap(
                    markers: Set<Marker>.of(markers.values),
                    mapType: MapType.normal,
                    tiltGesturesEnabled: false,

                    zoomControlsEnabled: false,
                    onCameraMoveStarted: () {
                      if (mounted) {
                        // key.currentState!.contract();
                        setState(() {
                          top = false;
                          bottomSheetExpanded = true;
                        });
                      }
                    },
                    onCameraMove: _onCameraMove,
                    onCameraIdle: () {
                      if (mounted) {
                        if (bottomSheetExpanded) {
                          // key.currentState!.expand();

                        }
                        setState(() {
                          top = true;
                        });
                        // _onCameraMove;
                        _updateAdress();
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      tilt: 0,
                      bearing: 0,
                      target: widget.initialPosition,
                      zoom: 17.00,
                    ),
                    // onTap: _handleTap,
                    // onCameraMove: _onCameraMove,
                    onMapCreated: (GoogleMapController controller) {
                      widget.mapController.complete(controller);
                      initialAnimateCamera();
                      //  key.currentState!.contract();
                    },
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Visibility(
                      visible: top,
                      child: const Icon(
                        FontAwesomeIcons.mapPin,
                        size: 40.0,
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Visibility(
                      visible: !top,
                      child: const Icon(
                        FontAwesomeIcons.mapPin,
                        size: 40.0,
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    bottom: 0,
                    right: -3,
                    left: 0,
                    child: Center(
                      child: Container(
                        height: 8,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 136, 136, 136),
                              blurRadius: 1.0, //effect of softening the shadow
                              spreadRadius:
                                  0.1, //effecet of extending the shadow
                              offset: Offset(
                                  0.0, //horizontal
                                  -2.0 //vertical
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
