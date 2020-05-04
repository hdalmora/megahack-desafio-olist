import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_resources.dart';
import 'firestore_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();
  final _firestoreResources = FirestoreResources();

  /// Authentication
  Stream<FirebaseUser> get onAuthStateChange => _authResources.onAuthStateChange;
  Future<void> signInWithGoogle(String role) => _authResources.signWithGoogle(role);
  Future<void> get signOut => _authResources.signOut;
  Future<FirebaseUser> get currentUser => _authResources.currentUser;

  /// Firestore
  Stream<DocumentSnapshot> userDoc(String userUUID) => _firestoreResources.userDOc(userUUID);
}