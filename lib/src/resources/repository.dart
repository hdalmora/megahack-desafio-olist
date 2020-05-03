import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_resources.dart';
import 'firestore_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();
  final _firestoreResources = FirestoreResources();

  /// Authentication
  Stream<FirebaseUser> get onAuthStateChange => _authResources.onAuthStateChange;
  Future<void> signInWithGoogle(String role) => _authResources.signWithGoogle(role);

}