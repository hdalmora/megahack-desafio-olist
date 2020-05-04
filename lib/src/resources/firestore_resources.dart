import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreResources {
  final Firestore _firestore = Firestore.instance;

  Stream<DocumentSnapshot> userDOc(String userUUID) => _firestore
      .collection("users")
      .document(userUUID)
      .snapshots();

  Future<QuerySnapshot> getRandomProduct() {
    var random = new Random();
    return _firestore
        .collection('products-questions')
        .where('random', isGreaterThanOrEqualTo: (random.nextInt(5) + 1))
        .orderBy('random')
        .limit(1)
        .getDocuments();
  }

  Future<void> addUserPoints(String userUID, double pointsToAdd) {
    return _firestore.runTransaction((transaction) async {
      DocumentSnapshot doc = await _firestore
          .collection("users")
          .document(userUID)
          .get();

      if(doc.data != null && doc.exists) {
        double currentPoints = doc.data['points'];

        double newPoints = currentPoints + pointsToAdd;
        await _firestore.collection("users")
            .document(userUID)
            .updateData({
            'points': newPoints
        });
      }
    });
  }
}