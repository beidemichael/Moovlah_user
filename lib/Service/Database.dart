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
      final CollectionReference savedPlacesCollection =
      FirebaseFirestore.instance.collection('SavedPlaces');

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
  List<OrdersModel> _ordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return OrdersModel(
        vehicleName: (doc.data() as dynamic)['vehicleName'] ?? '',
        vehicelPrice: (doc.data() as dynamic)['vehicelPrice'] ?? 0.0,
        extraServiceName: (doc.data() as dynamic)['extraServiceName'] ?? [],
        extraServicePrice: (doc.data() as dynamic)['extraServicePrice'] ?? [],
        specificationName: (doc.data() as dynamic)['specificationName'] ?? [],
        specificationPrice: (doc.data() as dynamic)['specificationPrice'] ?? [],
        orderRemark: (doc.data() as dynamic)['orderRemark'] ?? '',
        time: (doc.data() as dynamic)['time'] ?? Timestamp.now(),
        ordersModelLocationSub: OrdersModelLocationSub(
          locationListName: (doc.data() as dynamic)['locationListName'] ?? [],
          locationListcontactName:
              (doc.data() as dynamic)['locationListcontactName'] ?? [],
          locationListdescription:
              (doc.data() as dynamic)['locationListdescription'] ?? [],
          locationListfloorAndUnitNumber:
              (doc.data() as dynamic)['locationListfloorAndUnitNumber'] ?? [],
          locationListlocationLat:
              (doc.data() as dynamic)['locationListlocationLat'] ?? [],
          locationListlocationLong:
              (doc.data() as dynamic)['locationListlocationLong'] ?? [],
          specificLocationListlocationLat:
              (doc.data() as dynamic)['specificLocationListlocationLat'] ?? [],
          specificLocationListlocationLong:
              (doc.data() as dynamic)['specificLocationListlocationLong'] ?? [],
          locationListphoneNumber:
              (doc.data() as dynamic)['locationListphoneNumber'] ?? [],
        ),
        totalDistanceInt: (doc.data() as dynamic)['totalDistanceInt'] ?? 0,
        totalDistancePrice:
            (doc.data() as dynamic)['totalDistancePrice'] ?? 0.0,
        totalPrice: (doc.data() as dynamic)['totalPrice'] ?? 0.0,
        favouriteDriverFirst:
            (doc.data() as dynamic)['favouriteDriverFirst'] ?? false,
        isCanceled: (doc.data() as dynamic)['isCanceled'] ?? false,
        isDelivered: (doc.data() as dynamic)['isDelivered'] ?? false,
        isTaken: (doc.data() as dynamic)['isTaken'] ?? false,
        cash: (doc.data() as dynamic)['cash'] ?? false,
        paidBy: (doc.data() as dynamic)['paidBy'] ?? '',
        moreDetailsImage: (doc.data() as dynamic)['moreDetailsImage'] ?? '',
        userName: (doc.data() as dynamic)['userName'] ?? '',
        type: (doc.data() as dynamic)['type'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  Stream<List<OrdersModel>> get orders {
    return orderCollection
        .where('userUid', isEqualTo: userUid)
        .orderBy('time', descending: true)
        .snapshots()
        .handleError((onError) {
      print('errore in orders read: $onError');
    }).map(_ordersListFromSnapshot);
  }

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
    List specificLocationListlocationLat,
    List specificLocationListlocationLong,
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
          'specificLocationListlocationLat': specificLocationListlocationLat,
          'specificLocationListlocationLong': specificLocationListlocationLong,
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
          'isTaken': false,
          'isDelivered': false,
          'isCanceled': false,
        })
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to publish Order: $error"));
  }

  Future savedPlaces(String userUid, var location, String description) async {
    savedPlacesCollection
        .add({
          'created': Timestamp.now(),
          'userUid': userUid,
          'description': description,
        })
        .then((value) => print("savedPlaces Added"))
        .catchError((error) => print("Failed to publish savedPlaces: $error"));
  }
//3.2//////////////////Write//////////////////////////////////////////////////
//3///////////////////Order//////////////////////////////////////////////////
}
