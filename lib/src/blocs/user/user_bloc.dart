import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:megahackdesafioolist/src/blocs/bloc.dart';
import 'package:megahackdesafioolist/src/resources/repository.dart';

class UserBloc implements Bloc {
  final _repository = Repository();


  Future<void> get signOut => _repository.signOut;
  Future<FirebaseUser> get currentUser => _repository.currentUser;

  Stream<DocumentSnapshot> userDoc(String userUUID) => _repository.userDoc(userUUID);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}