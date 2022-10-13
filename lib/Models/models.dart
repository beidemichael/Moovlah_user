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
  double price = 0.0;

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
    // required this.price,
  });
}

class LocationList {
  String name;
  // ignore: prefer_typing_uninitialized_variables
  var location;
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
