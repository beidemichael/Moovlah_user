import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:provider/provider.dart';
import 'dart:async';
import 'package:geocoder2/geocoder2.dart';
import '../../Models/OrderModel.dart';
import '../../Service/Database.dart';
import '1.2,Map.dart';
import 'package:geolocator/geolocator.dart';
import '1.2.1, AddressDetails.dart';

// ignore: must_be_immutable
class LocationSearchScreen extends StatefulWidget {
  int index;
  String userUid;
  LocationSearchScreen({super.key, required this.index, required this.userUid});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  LatLng? _initialPosition;
  bool loading = false;
  var adressName;
  Completer<GoogleMapController> mapController = Completer();
  // GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "Search Location";
  late String description;

  var coordinate;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    setState(() {
      loading = true;
    });
    var _locationData;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _locationData = await Geolocator.getCurrentPosition();
    _initialPosition =
        LatLng(_locationData.latitude!, _locationData.longitude!);
    var fetchGeocoder = await Geocoder2.getDataFromCoordinates(
        latitude: _initialPosition!.latitude,
        longitude: _initialPosition!.longitude,
        googleMapApiKey: "AIzaSyDC8eK2_tywqgCtS8kLaOdrjs61aMVP1hI");
    adressName = fetchGeocoder.address;
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationList = Provider.of<Order>(context).locationListDisplay;

    return Scaffold(
        body: ExpandableBottomSheet(
      // onIsExtendedCallback: bottomSheetContract(),
      // onIsContractedCallback: bottomSheetContract(),
      key: key,
      enableToggle: true,
      expandableContent: Container(
        height: 400,
        color: Colors.white,
        child: Center(
          child: AddressDetail(index: widget.index),
        ),
      ),
      persistentHeader: Container(
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 189, 189, 189),
              blurRadius: 1.0, //effect of softening the shadow
              spreadRadius: 0.1, //effecet of extending the shadow
              offset: Offset(
                  0.0, //horizontal
                  -2.0 //vertical
                  ),
            ),
          ],
        ),
        child: Center(
          child: Container(
            height: 8,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
            ),
          ),
        ),
      ),
      background: Stack(
        children: [
          Center(
            child: MapForLocation(
              mapController: mapController,
              cameraPosition: cameraPosition,
              index: widget.index,
              loading: loading,
              initialPosition: _initialPosition,
            ),
          ),
          Positioned(
            top: 100,
            child: Visibility(
              visible: locationList[widget.index].description == '',
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.shade500,
                    //     blurRadius: 1.0, //effect of softening the shadow
                    //     spreadRadius: 0.1, //effecet of extending the shadow
                    //     offset: const Offset(
                    //         0.0, //horizontal
                    //         1.0 //vertical
                    //         ),
                    //   ),
                    // ],
                    color: Colors.white.withOpacity(0.6),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 170,
            right: 30,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Provider.of<Order>(context, listen: false)
                      .addLocationPosition(
                          adressName, _initialPosition, widget.index);
                  key.currentState!.expand();
                  // print(key.currentState!.expansionStatus);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    // border: Border.all(
                    //     width: 1,
                    //     color:
                    //         const Color.fromARGB(255, 112, 112, 112)),
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade700,
                        blurRadius: 2.0, //effect of softening the shadow
                        spreadRadius: 0.7, //effecet of extending the shadow
                        offset: const Offset(
                            0.0, //horizontal
                            0.0 //vertical
                            ),
                      ),
                    ],
                  ),
                  child: const Icon(
                    FontAwesomeIcons.crosshairs,
                    size: 20.0,
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                ),
              ),
            ),
          ),
          //search autocomplete input

          Positioned(
            //search input bar
            top: 60,
            child: InkWell(
              onTap: () async {
                var place = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: "AIzaSyDC8eK2_tywqgCtS8kLaOdrjs61aMVP1hI",
                    mode: Mode.overlay,
                    types: [],
                    strictbounds: false,
                    // hint: locationList[widget.index].toString(),
                    components: [Component(Component.country, 'sg')],
                    //google_map_webservice package
                    onError: (err) {
                      print(err);
                    });
                if (place == null) {
                  // setState(() {
                  //   recentPlaces = true;
                  // });
                }

                if (place != null) {
                  Provider.of<Order>(context, listen: false)
                      .locationInputLoading();
                  location = place.description.toString();
                  description = place.description.toString();

                  //form google_maps_webservice package
                  final plist = GoogleMapsPlaces(
                    apiKey: "AIzaSyDC8eK2_tywqgCtS8kLaOdrjs61aMVP1hI",
                    apiHeaders: await const GoogleApiHeaders().getHeaders(),
                    //from google_api_headers package
                  );
                  String placeid = place.placeId ?? "0";
                  final detail = await plist.getDetailsByPlaceId(placeid);
                  final geometry = detail.result.geometry!;
                  final lat = geometry.location.lat;
                  final lang = geometry.location.lng;
                  var newlatlang = LatLng(lat, lang);
                  //move map camera to selected place with animation

                  final c = await mapController.future;
                  final p = CameraPosition(target: newlatlang, zoom: 17);
                  c.animateCamera(CameraUpdate.newCameraPosition(p));
                  coordinate = LatLng(lat, lang);
                  // ignore: use_build_context_synchronously
                  Provider.of<Order>(context, listen: false)
                      .addLocationPosition(
                          description, coordinate, widget.index);
                  DatabaseService()
                      .savedPlaces(widget.userUid, coordinate, description);
                  Provider.of<Order>(context, listen: false)
                      .locationInputLoading();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 1.0, //effect of softening the shadow
                        spreadRadius: 0.1, //effecet of extending the shadow
                        offset: const Offset(
                            0.0, //horizontal
                            1.0 //vertical
                            ),
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: ListTile(
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back)),
                    title: Text(
                      locationList[widget.index].description == ''
                          ? location
                          : locationList[widget.index].description,
                      style: const TextStyle(
                          fontSize: 18, color: Color.fromARGB(255, 63, 63, 63)),
                    ),
                    trailing: const Icon(Icons.search),
                    dense: true,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
