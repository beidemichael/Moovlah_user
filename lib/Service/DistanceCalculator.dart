// ignore_for_file: file_names

import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DistanceCalculator {
  double startLat;
  double startLong;
  double endLat;
  double endLong;

  DistanceCalculator(
      {required this.startLat,
      required this.startLong,
      required this.endLat,
      required this.endLong});
  Map<PolylineId, Polyline> polylines = {};
  String googleAPIKey = "AIzaSyDC8eK2_tywqgCtS8kLaOdrjs61aMVP1hI";
  TravelMode travelModeOption = TravelMode.driving;
  PolylinePoints? polylinePoints;
  List<LatLng> polylineCoordinates = [];
  double distance = 0;

   createPolylines() async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      googleAPIKey, // Google Maps API Key
      PointLatLng(startLat, startLong),
      PointLatLng(endLat, endLong),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      distance = distance +
          calculateDistance(
              polylineCoordinates[i].latitude,
              polylineCoordinates[i].longitude,
              polylineCoordinates[i + 1].latitude,
              polylineCoordinates[i + 1].longitude);
    }
    return distance;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
