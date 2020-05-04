import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreResources {
  final Firestore _firestore = Firestore.instance;

  Stream<DocumentSnapshot> userDOc(String userUUID) => _firestore
      .collection("users")
      .document(userUUID)
      .snapshots();
}