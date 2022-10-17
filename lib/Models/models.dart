import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserAuth {
  final String uid;
  UserAuth({required this.uid});
}

class UserInformation {
  String userName;
  String phoneNumber;
  String email;
  String type;
  String userUid;
  String businessName;
  bool proofOfDelivery;
  String documentId;

  UserInformation({
    required this.userName,
    required this.email,
    required this.type,
    required this.phoneNumber,
    required this.userUid,
    required this.businessName,
    required this.proofOfDelivery,
    required this.documentId,
  });
}

class Vehicles {
  String type;
  String documentId;
  String description;
  String capacity;
  String dimension;
  String image;
  List extraService;
  List extraServicePrice;
  List specification;
  List specificationPrice;
  num price;
  num pricePerKM;

  Vehicles({
    required this.documentId,
    required this.type,
    required this.description,
    required this.capacity,
    required this.dimension,
    required this.image,
    required this.extraService,
    required this.extraServicePrice,
    required this.specification,
    required this.specificationPrice,
    required this.price,
    required this.pricePerKM,
  });
}

class LocationList {
  String name;
  // ignore: prefer_typing_uninitialized_variables
  LatLng location;
  String description;
  String phoneNumber;
  String contactName;
  String floorAndUnitNumber;
  LocationList(
      {required this.name,
      required this.location,
      required this.description,
      required this.contactName,
      required this.floorAndUnitNumber,
      required this.phoneNumber});
}

class OrdersModelLocationSub {
  List locationListName;
  List locationListlocationLat;
  List locationListlocationLong;
  List locationListdescription;
  List locationListphoneNumber;
  List locationListcontactName;
  List locationListfloorAndUnitNumber;
  OrdersModelLocationSub({
    required this.locationListName,
    required this.locationListcontactName,
    required this.locationListdescription,
    required this.locationListfloorAndUnitNumber,
    required this.locationListlocationLat,
    required this.locationListlocationLong,
    required this.locationListphoneNumber,
  });
}

class OrdersModel {
  String vehicleName;
  double vehicelPrice;
  List extraServiceName;
  List extraServicePrice;
  List specificationName;
  List specificationPrice;
  String orderRemark;
  Timestamp time;
  OrdersModelLocationSub ordersModelLocationSub;
  int totalDistanceInt;
  double totalDistancePrice;
  double totalPrice;
  bool favouriteDriverFirst;
  bool cash;
  String paidBy;
  var moreDetailsImage;
  String userName;
  String type;
  String email;
  String userUid;
  String documentId;
  bool isTaken;
  bool isDelivered;
  bool isCanceled;
  OrdersModel(
      {required this.cash,
      required this.email,
      required this.extraServiceName,
      required this.extraServicePrice,
      required this.favouriteDriverFirst,
      required this.moreDetailsImage,
      required this.orderRemark,
      required this.paidBy,
      required this.specificationName,
      required this.specificationPrice,
      required this.time,
      required this.totalDistanceInt,
      required this.totalDistancePrice,
      required this.totalPrice,
      required this.type,
      required this.userName,
      required this.userUid,
      required this.vehicelPrice,
      required this.vehicleName,
      required this.documentId,
      required this.ordersModelLocationSub,
      required this.isCanceled,
      required this.isDelivered,
      required this.isTaken
      });
}
