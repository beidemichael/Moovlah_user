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

////////////////////User//////////////////////////////////////////////////
////////////////////Write//////////////////////////////////////////////////
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

////////////////////Write//////////////////////////////////////////////////
////////////////////Edit//////////////////////////////////////////////////
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
////////////////////Edit//////////////////////////////////////////////////
////////////////////User//////////////////////////////////////////////////
////////////////////Read//////////////////////////////////////////////////

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
////////////////////Read//////////////////////////////////////////////////
}
