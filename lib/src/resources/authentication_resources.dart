import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationResources {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<FirebaseUser> get onAuthStateChange => _firebaseAuth.onAuthStateChanged;

  Future<int> signWithGoogle(String role) async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);

      if(authResult.additionalUserInfo.isNewUser) {
        await createUserProfileForGoogle(authResult.user, null, role);
      }

      return 1;
    } on PlatformException catch (e) {
      print(
          "Platform Exception: Error communicating with the Google Platform: {$e}");
      return -1;
    } catch (e) {
      print("Exception: Error: ${e.toString()}");
      return -2;
    }
  }

  Future<void> createUserProfileForGoogle(FirebaseUser user, String displayName, String role) => _firestore
      .collection("users")
      .document(user.uid)
      .setData({
    'id': user.uid,
    'role': role,
    'name': displayName != null ? displayName : user.displayName,
    'experience': 0.0,
    'level': 1,
    'points': 0.0,
    'profileImageUrl': user.photoUrl
  });


  Future<void> get signOut async {
    _firebaseAuth.signOut();
    _googleSignIn.signOut();
  }
}