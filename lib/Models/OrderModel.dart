import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovlah_user/Models/models.dart';

class Order extends ChangeNotifier {
  String vehicleName = '';
  double vehicelPrice = 0;
  List extraServiceName = [];
  List extraServicePrice = [];
  List specificationName = [];
  List specificationPrice = [];
  List<LocationList> locationList = [
    LocationList(
        name: 'Pick-up location',
        location: LatLng(0.0, 0.0),
        description: '',
        phoneNumber: '',
        contactName: '',
        floorAndUnitNumber: ''),
    LocationList(
        name: 'Drop-off location',
        location: LatLng(0.0, 0.0),
        description: '',
        phoneNumber: '',
        contactName: '',
        floorAndUnitNumber: '')
  ];
  bool locationListComplete = false;
  bool vehicleSelected = false;
  bool vehicleAndLocationComplete = false;
  int completeLocations = 0;

  List get locationListDisplay => locationList;
  String get vehicleNameDisplay => vehicleName;
  List get vehicleServiceDisplay => extraServiceName;
  List get vehicleSpecificationDisplay => specificationName;

  void addLocation(LocationList locationFunction) {
    locationList.add(locationFunction);
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
    print('Locaion Added');
    notifyListeners();
  }

  void removeLocation(int index) {
    locationList.remove(locationList[index]);
    notifyListeners();
  }

  void addVehicle(String vehicleNameFunction, double vehiclePriceFunction) {
    if (vehicleName == vehicleNameFunction) {
      vehicleName = '';
      vehicelPrice = 0.0;
      extraServiceName.clear();
      extraServicePrice.clear();
      specificationName.clear();
      specificationPrice.clear();
    } else {
      vehicleName = vehicleNameFunction;
      vehicelPrice = vehiclePriceFunction;
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
    }
    else{
      vehicleAndLocationComplete = false;
    }
    return vehicleAndLocationComplete;
  }
}
