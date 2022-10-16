// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/models.dart';

class DatabaseService {
  var userUid;

  DatabaseService({this.userUid});

  final CollectionReference vehiclesCollection =
      FirebaseFirestore.instance.collection('Vehicles');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');

//1//////////////////User//////////////////////////////////////////////////
//1.1//////////////////Write//////////////////////////////////////////////////
  Future newUserData(
    String userName,
    String phoneNumber,
    String email,
    String password,
    String type,
    String userUid,
    String businessName,
  ) async {
    userCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (docs.docs.isEmpty) {
        return await userCollection.doc(userUid).set({
          'created': Timestamp.now(),
          'name': userName,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
          'type': type,
          'userUid': userUid,
          'businessName': businessName,
          'proofOfDelivery': false,
        });
      }
    });
  }

//1.1//////////////////Write//////////////////////////////////////////////////
//1.2//////////////////Edit//////////////////////////////////////////////////
  Future updateProofOfDelivery(
    bool proofOfDelivery,
    String userUid,
  ) async {
    return await userCollection.doc(userUid).update({
      'proofOfDelivery': !proofOfDelivery,
    });
  }

  Future updateUsername(
    String userName,
    String userUid,
  ) async {
    return await userCollection.doc(userUid).update({
      'name': userName,
    });
  }
//1.2//////////////////Edit//////////////////////////////////////////////////
//1.3//////////////////Read//////////////////////////////////////////////////

  List<UserInformation> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInformation(
        userName: (doc.data() as dynamic)['name'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        type: (doc.data() as dynamic)['type'] ?? false,
        phoneNumber: (doc.data() as dynamic)['phoneNumber'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        businessName: (doc.data() as dynamic)['businessName'] ?? '',
        proofOfDelivery: (doc.data() as dynamic)['proofOfDelivery'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<UserInformation>> get userInfo {
    return userCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }

//1.3//////////////////Read//////////////////////////////////////////////////
//1///////////////////User//////////////////////////////////////////////////
//2///////////////////Vehicle//////////////////////////////////////////////////
//2.1//////////////////Read//////////////////////////////////////////////////
//Read vehicle list.
  List<Vehicles> _vehiclesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Vehicles(
        type: (doc.data() as dynamic)['Type'] ?? '',
        description: (doc.data() as dynamic)['Description'] ?? '',
        capacity: (doc.data() as dynamic)['Capacity'] ?? '',
        dimension: (doc.data() as dynamic)['Dimension'] ?? '',
        image: (doc.data() as dynamic)['Image'] ?? '',
        extraService: (doc.data() as dynamic)['ExtraService'] ?? [],
        extraServicePrice: (doc.data() as dynamic)['ExtraServicePrice'] ?? [],
        specification: (doc.data() as dynamic)['Specification'] ?? [],
        specificationPrice: (doc.data() as dynamic)['SpecificationPrice'] ?? [],
        price: (doc.data() as dynamic)['Price'] ?? 0.0,
        pricePerKM: (doc.data() as dynamic)['PerKM'] ?? 0.0,
        documentId: doc.reference.id,
      );
    }).toList();
  }

  Stream<List<Vehicles>> get vehicles {
    return vehiclesCollection
        .orderBy('Order', descending: false)
        .snapshots()
        .handleError((onError) {
      print(onError.toString());
    }).map(_vehiclesListFromSnapshot);
  }

//2.1//////////////////Read//////////////////////////////////////////////////
//2///////////////////Vehicle//////////////////////////////////////////////////
//3///////////////////Order//////////////////////////////////////////////////
//3.1//////////////////Read//////////////////////////////////////////////////
//3.1//////////////////Read//////////////////////////////////////////////////
//3.2//////////////////Write//////////////////////////////////////////////////
  Future order(
    String vehicleName,
    double vehicelPrice,
    List extraServiceName,
    List extraServicePrice,
    List specificationName,
    List specificationPrice,
    String orderRemark,
    DateTime time,
    List locationListName,
    List locationListlocationLat,
    List locationListlocationLong,
    List locationListdescription,
    List locationListphoneNumber,
    List locationListcontactName,
    List locationListfloorAndUnitNumber,
    int totalDistanceInt,
    double totalDistancePrice,
    double totalPrice,
    bool favouriteDriverFirst,
    bool cash,
    String paidBy,
    var moreDetailsImage,
    String userName,
    String type,
    String email,
    String userUid,
  ) async {
    orderCollection
        .add({
          'vehicleName': vehicleName,
          'vehicelPrice': vehicelPrice,
          'extraServiceName': extraServiceName,
          'extraServicePrice': extraServicePrice,
          'specificationName': specificationName,
          'specificationPrice': specificationPrice,
          'orderRemark': orderRemark,
          'time': time,
          'locationListName': locationListName,
          'locationListlocationLat': locationListlocationLat,
          'locationListlocationlong': locationListlocationLong,
          'locationListdescription': locationListdescription,
          'locationListphoneNumber': locationListphoneNumber,
          'locationListcontactName': locationListcontactName,
          'locationListfloorAndUnitNumber': locationListfloorAndUnitNumber,
          'totalDistanceInt': totalDistanceInt,
          'totalDistancePrice': totalDistancePrice,
          'totalPrice': totalPrice,
          'favouriteDriverFirst': favouriteDriverFirst,
          'cash': cash,
          'paidBy': paidBy,
          'moreDetailsImage': moreDetailsImage,
          'userName': userName,
          'type': type,
          'email': email,
          'userUid': userUid,
        })
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to publish Order: $error"));
  }
//3.2//////////////////Write//////////////////////////////////////////////////
//3///////////////////Order//////////////////////////////////////////////////
}
