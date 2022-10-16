// ignore_for_file: unused_import, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart';
import 'package:moovlah_user/Models/models.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../Models/OrderModel.dart';
import '1.2,Map.dart';

// ignore: must_be_immutable
class LocationSearchScreen extends StatefulWidget {
  int index;
  LocationSearchScreen({super.key, required this.index});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  Completer<GoogleMapController> mapController = Completer();
  // GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "Search Location";
  late String description;
  var coordinate;

  @override
  Widget build(BuildContext context) {
    final locationList = Provider.of<Order>(context).locationListDisplay;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: MapForLocation(
              mapController: mapController,
              cameraPosition: cameraPosition,
              index: widget.index,
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
                    components: [Component(Component.country, 'sg')],
                    //google_map_webservice package
                    onError: (err) {
                      print(err);
                    });

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
                      location,
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
    );
  }
}
