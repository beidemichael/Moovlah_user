// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovlah_user/Models/models.dart';
import 'package:moovlah_user/Service/DistanceCalculator.dart';

class Order extends ChangeNotifier {
/*
1, Assigning Variables
2, Displaying informaton
3, Variable manipulation

 */

///////////1
  /////////////////////////Sceeen/////////////////////////////
  String screen = 'welcome';
  /////////////////////////Screen/////////////////////////////
  /////////////////////////Vehicle/////////////////////////////
  String vehicleName = '';
  double vehicelPrice = 0;
  double vehicelPricePerKM = 0.0;
  List extraServiceName = [];
  List extraServicePrice = [];
  List specificationName = [];
  List specificationPrice = [];
  bool vehicleSelected = false;
  /////////////////////////Vehicle/////////////////////////////
  ///
  ///
  /////////////////////////InBetween/////////////////////////////
  String orderRemark = '';
  DateTime time = DateTime.now();
  List<LocationList> locationList = [
    LocationList(
        name: 'Pick-up location',
        location: const LatLng(0.0, 0.0),
        description: '',
        phoneNumber: '',
        contactName: '',
        floorAndUnitNumber: ''),
    LocationList(
        name: 'Drop-off location',
        location: const LatLng(0.0, 0.0),
        description: '',
        phoneNumber: '',
        contactName: '',
        floorAndUnitNumber: '')
  ];
  /////////////////////////InBetween/////////////////////////////
  ///
  ///
  /////////////////////////PriceCalculation/////////////////////////////
  bool priceCalculating = false;
  double totalDistance = 0.0;
  int totalDistanceInt = 0;

  bool finishedRouting = false;
  double totalExtraServicesPrice = 0.0;
  double totalSpecificationsPrice = 0.0;
  double totalDistancePrice = 0.0;
  double totalPrice = 0.0;
  /////////////////////////PriceCalculation/////////////////////////////
  ///
  ///
  /////////////////////////CompleteVerification/////////////////////////////

  bool locationListComplete = false;
  bool vehicleAndLocationComplete = false;
  int completeLocations = 0;
  /////////////////////////CompleteVerification/////////////////////////////
  ///
  ///
  /////////////////////////FinalOrderScreen/////////////////////////////
  bool favouriteDriverFirst = false;
  bool cash = false;
  var moreDetailsImage;
  /////////////////////////FinalOrderScreen/////////////////////////////
///////////2
  /////////////////////////////////////////////////////////////////////////
  String get screenDisplay => screen;
  //
  List get locationListDisplay => locationList;
  DateTime get timeDisplay => time;
  //
  bool get priceCalculatingDisplay => priceCalculating;
  String get vehicleNameDisplay => vehicleName;
  List get vehicleServiceDisplay => extraServiceName;
  List get vehicleSpecificationDisplay => specificationName;
  //
  int get totalDistanceIntDisplay => totalDistanceInt;
  double get totalDistancePriceDisplay => totalDistancePrice;
  double get totalSpecificationsPriceDisplay => totalSpecificationsPrice;
  double get totalExtraServicesPriceDisplay => totalExtraServicesPrice;
  double get totalPriceDisplay => totalPrice;
  //
  get moreDetailsImageDisplay => moreDetailsImage;
  bool get favouriteDriverFirstDisplay => favouriteDriverFirst;
  bool get cashDisplay => cash;

  /////////////////////////////////////////////////////////////////////////
//////////3
  /////////////////////////////////////////////////////////////////////////

  void changeScreen(String screenFunction) {
    screen = screenFunction;
    notifyListeners();
  }

  void addLocation(LocationList locationFunction) {
    locationList.add(locationFunction);
    resetVariables();
    calculateTotalPrice();
    notifyListeners();
  }

  void addTime(DateTime timeFunction) {
    time = timeFunction;
    notifyListeners();
  }

  void addMidLocation() {
    LocationList lastLocation = locationList.last;
    locationList.remove(locationList.last);
    locationList.add(LocationList(
        name: 'Mid-stop location',
        location: const LatLng(0.0, 0.0),
        description: '',
        phoneNumber: '',
        contactName: '',
        floorAndUnitNumber: ''));
    locationList.add(lastLocation);
    if (kDebugMode) {
      print('Locaion Added');
    }
    resetVariables();
    calculateTotalPrice();
    notifyListeners();
  }

  void addLocationInfo(String phoneNumberFunction, String contactNameFunction,
      String floorAndUnitNumberFunction, int indexFunction) {
    locationList[indexFunction].contactName = contactNameFunction;
    locationList[indexFunction].phoneNumber = phoneNumberFunction;
    locationList[indexFunction].floorAndUnitNumber = floorAndUnitNumberFunction;
    notifyListeners();
  }

  void addLocationPosition(
      String descriptionFunction, var locationFunction, int indexFunction) {
    locationList[indexFunction].description = descriptionFunction;
    locationList[indexFunction].location = locationFunction;
    notifyListeners();
  }

  void removeLocation(int index) {
    locationList.remove(locationList[index]);
    vehicleName = '';
    notifyListeners();
  }

  locationDescription(int indexFunction) {
    return locationList[indexFunction].description;
  }

  void addVehicle(String vehicleNameFunction, double vehiclePriceFunction,
      double vehicelPricePerKMFunction) {
    if (vehicleName == vehicleNameFunction) {
      vehicleName = '';
      vehicelPrice = 0.0;
      vehicelPricePerKM = 0.0;
      extraServiceName.clear();
      extraServicePrice.clear();
      specificationName.clear();
      specificationPrice.clear();
    } else {
      vehicleName = vehicleNameFunction;
      vehicelPrice = vehiclePriceFunction;
      vehicelPricePerKM = vehicelPricePerKMFunction;
      extraServiceName.clear();
      extraServicePrice.clear();
      specificationName.clear();
      specificationPrice.clear();
    }
    notifyListeners();
  }

  void addExtraService(
      String extraServiceNameFunction, double extraServicePriceFunction) {
    if (extraServiceName.contains(extraServiceNameFunction)) {
      extraServiceName.remove(extraServiceNameFunction);
      extraServicePrice.remove(extraServicePriceFunction);
    } else {
      extraServiceName.add(extraServiceNameFunction);
      extraServicePrice.add(extraServicePriceFunction);
    }
    resetVariables();
    calculateTotalPrice();

    notifyListeners();
  }

  void addSpecification(
      String specificationNameFunction, double specificationPriceFunction) {
    if (specificationName.contains(specificationNameFunction)) {
      specificationName.remove(specificationNameFunction);
      specificationPrice.remove(specificationPriceFunction);
    } else {
      specificationName.add(specificationNameFunction);
      specificationPrice.add(specificationPriceFunction);
    }
    resetVariables();
    calculateTotalPrice();
    notifyListeners();
  }

  checkLocationInputIsAllFilled() {
    for (int i = 0; i < locationList.length; i++) {
      if (locationList[i].description != '') {
        completeLocations++;
      }
    }
    if (completeLocations == locationList.length) {
      locationListComplete = true;
    } else {
      locationListComplete = false;
    }
    completeLocations = 0;
    if (vehicleName != '') {
      vehicleSelected = true;
    } else {
      vehicleSelected = false;
    }
    if (vehicleSelected == true && locationListComplete == true) {
      vehicleAndLocationComplete = true;

      
      calculateTotalPrice();
    } else {
      vehicleAndLocationComplete = false;
      resetVariables();
    }

    return vehicleAndLocationComplete;
  }

  calculateTotalDistanceFunction() async {
    for (int i = 0; i < locationList.length - 1; i++) {
      totalDistance = totalDistance +
          await DistanceCalculator(
            startLat: locationList[i].location.latitude,
            startLong: locationList[i].location.longitude,
            endLat: locationList[i + 1].location.latitude,
            endLong: locationList[i + 1].location.longitude,
          ).createPolylines();
    }
    totalDistanceInt = totalDistance.round();
    notifyListeners();
  }

  calculateTotalPrice() {
    if (finishedRouting == false) {
      priceCalculating = true;
      calculateTotalDistanceFunction();
      for (int i = 0; i < extraServicePrice.length - 1; i++) {
        totalExtraServicesPrice =
            totalExtraServicesPrice + extraServicePrice[i];
      }
      for (int i = 0; i < specificationPrice.length - 1; i++) {
        totalSpecificationsPrice =
            totalSpecificationsPrice + specificationPrice[i];
      }
      totalDistancePrice = vehicelPricePerKM * totalDistanceInt;
      totalPrice = vehicelPrice +
          totalExtraServicesPrice +
          totalExtraServicesPrice +
          totalDistancePrice;
      priceCalculating = false;
      finishedRouting = true;
    }
  }

  resetVariables() {
    totalDistance = 0;
    totalDistanceInt = 0;
    totalDistancePrice = 0.0;
    totalExtraServicesPrice = 0.0;
    totalPrice = 0.0;
    totalSpecificationsPrice = 0.0;
    finishedRouting = false;
  }

  void addNote(String noteFunction) {
    orderRemark = noteFunction;
    notifyListeners();
  }

  void selectFavouriteDriverFirst() {
    favouriteDriverFirst = !favouriteDriverFirst;
    notifyListeners();
  }

  void addMoreDetailsImage(File moreDetailsImageFunction) {
    moreDetailsImage = moreDetailsImageFunction;
    notifyListeners();
  }

  void selectCash() {
    cash = !cash;
    notifyListeners();
  }
}
