import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/models.dart';

class DatabaseService {
  var userUid;
  var catForNews;
  var lastVisible;

  DatabaseService({this.userUid, this.catForNews, this.lastVisible});

  final CollectionReference vehiclesCollection =
      FirebaseFirestore.instance.collection('Vehicles');
////////////////////Read//////////////////////////////////////////////////

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
