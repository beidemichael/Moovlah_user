// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovlah_user/Models/models.dart';
import 'package:moovlah_user/Service/DistanceCalculator.dart';

import '../Service/Database.dart';

class Order extends ChangeNotifier {
/*
1, Assigning Variables
2, Displaying informaton
3, Variable manipulation

 */

///////////1
  /////////////////////////Sceeen/////////////////////////////
  String screen = 'welcome';
  bool dartMode = false;
  /////////////////////////Screen/////////////////////////////
  /////////////////////////Vehicle/////////////////////////////
  String vehicleName = '';
  double vehicelPrice = 0;
  double vehicelPricePerKM = 0.0;
  List extraServiceName = [];
  List<double> extraServicePrice = [];
  List specificationName = [];
  List<double> specificationPrice = [];
  bool vehicleSelected = false;
  /////////////////////////Vehicle/////////////////////////////
  ///
  /***********************************************************/
  ///
  /////////////////////////InBetween///////////////////////////
  String orderRemark = '';
  DateTime time = DateTime.now();
  List<LocationList> locationList = [
    LocationList(
        name: 'Pick-up location',
        location: const LatLng(0.0, 0.0),
        specificLocaion: const LatLng(0.0, 0.0),
        description: '',
        phoneNumber: '',
        contactName: '',
        floorAndUnitNumber: ''),
    LocationList(
        name: 'Drop-off location',
        location: const LatLng(0.0, 0.0),
        specificLocaion: const LatLng(0.0, 0.0),
        description: '',
        phoneNumber: '',
        contactName: '',
        floorAndUnitNumber: '')
  ];
  List locationListName = [];
  List locationListlocationLat = [];
  List locationListlocationLong = [];
  List specificLocationListlocationLat = [];
  List specificLocationListlocationLong = [];
  List locationListdescription = [];
  List locationListphoneNumber = [];
  List locationListcontactName = [];
  List locationListfloorAndUnitNumber = [];

  bool locationInput = false;

  /////////////////////////InBetween/////////////////////////////
  ///
  ///
  /////////////////////////PriceCalculation/////////////////////////////
  bool priceCalculating = false;
  double totalDistance = 0.0;
  int totalDistanceInt = 0;
  int totalDistanceIntAsBool = 0;

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
  String paidBy = '';
  var moreDetailsImage;
  /////////////////////////FinalOrderScreen/////////////////////////////
  ///
  ///
  /////////////////////////OrderPublishing/////////////////////////////
  String newImage = '';
  bool upLoading = false;
  /////////////////////////OrderPublishing/////////////////////////////
  ///
  ///
///////////2
  /////////////////////////////////////////////////////////////////////////
  String get screenDisplay => screen;
  //
  List get locationListDisplay => locationList;
  DateTime get timeDisplay => time;
  //

  String get vehicleNameDisplay => vehicleName;
  List get vehicleServiceDisplay => extraServiceName;
  List get vehicleSpecificationDisplay => specificationName;
  //
  bool get priceCalculatingDisplay => priceCalculating;
  int get totalDistanceIntDisplay => totalDistanceInt;
  int get totalDistanceIntAsBoolDisplay => totalDistanceIntAsBool;
  double get vehicelePriceDisplay => vehicelPrice;
  double get totalDistancePriceDisplay => totalDistancePrice;
  double get totalSpecificationsPriceDisplay => totalSpecificationsPrice;
  double get totalExtraServicesPriceDisplay => totalExtraServicesPrice;
  double get totalPriceDisplay => totalPrice;

  bool get locationInputDisplay => locationInput;
  //
  get moreDetailsImageDisplay => moreDetailsImage;
  bool get favouriteDriverFirstDisplay => favouriteDriverFirst;
  bool get cashDisplay => cash;
  String get paidByDisplay => paidBy;
  String get orderRemarkDisplay => orderRemark;
  //
  bool get uploadingDisplay => upLoading;

  /////////////////////////////////////////////////////////////////////////
//////////3
  /////////////////////////////////////////////////////////////////////////

  void changeScreen(String screenFunction) {
    screen = screenFunction;
    notifyListeners();
  }
  void changeDartMode() {
    dartMode = !dartMode;
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
        specificLocaion: const LatLng(0.0, 0.0),
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

  void locationInputLoading() {
    locationInput = !locationInput;
    notifyListeners();
  }

  void addLocationPosition(
      String descriptionFunction, var locationFunction, int indexFunction) {
    locationList[indexFunction].description = descriptionFunction;
    locationList[indexFunction].location = locationFunction;
    notifyListeners();
  }

  void addSpecificLocationPosition(var locationFunction, int indexFunction) {
    locationList[indexFunction].specificLocaion = locationFunction;
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
    resetVariables();
    calculateTotalPrice();
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
    if (totalDistanceInt >= 5 && vehicleName == 'Walker/Bicycle') {
      vehicleName = '';
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
    if (totalDistanceInt != 0) {
      totalDistanceIntAsBool = totalDistanceInt;
    }

    if (kDebugMode) {
      print('totalDistanceInt: ' + totalDistanceInt.toString());
    }
    for (int i = 0; i < extraServicePrice.length; i++) {
      totalExtraServicesPrice = totalExtraServicesPrice + extraServicePrice[i];
    }
    for (int i = 0; i < specificationPrice.length; i++) {
      totalSpecificationsPrice =
          totalSpecificationsPrice + specificationPrice[i];
    }
    totalDistancePrice =
        (vehicelPricePerKM * totalDistanceInt).toInt().toDouble();
    totalPrice = vehicelPrice +
        totalExtraServicesPrice +
        totalSpecificationsPrice +
        totalDistancePrice;
    notifyListeners();
  }

  calculateTotalPrice() {
    if (finishedRouting == false) {
      priceCalculating = true;
      calculateTotalDistanceFunction();
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

  void selectPaidBy(String paidByFunction) {
    paidBy = paidByFunction;
    notifyListeners();
  }

  void prepareVariablesForNewOrder() {
    resetVariables();
    vehicleSelected = false;
    locationList.clear();
    locationList = [
      LocationList(
          name: 'Pick-up location',
          location: const LatLng(0.0, 0.0),
          specificLocaion: const LatLng(0.0, 0.0),
          description: '',
          phoneNumber: '',
          contactName: '',
          floorAndUnitNumber: ''),
      LocationList(
          name: 'Drop-off location',
          location: const LatLng(0.0, 0.0),
          specificLocaion: const LatLng(0.0, 0.0),
          description: '',
          phoneNumber: '',
          contactName: '',
          floorAndUnitNumber: '')
    ];
    locationListName.clear();
    locationListlocationLat.clear();
    locationListlocationLong.clear();
    locationListdescription.clear();
    specificLocationListlocationLat.clear();
    specificLocationListlocationLong.clear();
    locationListphoneNumber.clear();
    locationListcontactName.clear();
    locationListfloorAndUnitNumber.clear();
    vehicleName = '';
    vehicelPrice = 0.0;
    vehicelPricePerKM = 0.0;
    extraServiceName.clear();
    extraServicePrice.clear();
    specificationName.clear();
    specificationPrice.clear();
    orderRemark = '';
    time = DateTime.now();
    totalDistanceInt = 0;
    totalDistancePrice = 0.0;
    totalPrice = 0.0;
    favouriteDriverFirst = false;
    cash = false;
    paidBy = '';
    newImage = '';
    moreDetailsImage = null;
    notifyListeners();
  }

  Future<void> publishOrder(
      BuildContext context, UserInformation userInfo) async {
    upLoading = true;
    notifyListeners();
    for (int i = 0; i < locationList.length; i++) {
      locationListName.add(locationList[i].name);
      locationListlocationLat.add(locationList[i].location.latitude);
      locationListlocationLong.add(locationList[i].location.longitude);
      specificLocationListlocationLat
          .add(locationList[i].specificLocaion.latitude);
      specificLocationListlocationLong
          .add(locationList[i].specificLocaion.longitude);
      locationListdescription.add(locationList[i].description);
      locationListphoneNumber.add(locationList[i].phoneNumber);
      locationListcontactName.add(locationList[i].contactName);
      locationListfloorAndUnitNumber.add(locationList[i].floorAndUnitNumber);
    }

    if (moreDetailsImage != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(
          "OrderDetailedImage/DetailedImage" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(moreDetailsImage!);

      await uploadTask.then((res) async {
        final String downloadUrl = await res.ref.getDownloadURL();

        newImage = downloadUrl;
      });
    }

    DatabaseService().order(
        vehicleName,
        vehicelPrice,
        extraServiceName,
        extraServicePrice,
        specificationName,
        specificationPrice,
        orderRemark,
        time,
        locationListName,
        locationListlocationLat,
        locationListlocationLong,
        specificLocationListlocationLat,
        specificLocationListlocationLong,
        locationListdescription,
        locationListphoneNumber,
        locationListcontactName,
        locationListfloorAndUnitNumber,
        totalDistanceInt,
        totalDistancePrice,
        totalPrice,
        favouriteDriverFirst,
        cash,
        paidBy,
        newImage,
        userInfo.userName,
        userInfo.type,
        userInfo.email,
        userInfo.userUid);
    upLoading = false;
    notifyListeners();
    prepareVariablesForNewOrder();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(seconds: 2),
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              'Order Published',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300),
            ),
          ],
        )));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
