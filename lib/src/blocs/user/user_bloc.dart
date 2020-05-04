import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:megahackdesafioolist/src/blocs/bloc.dart';
import 'package:megahackdesafioolist/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc implements Bloc {
  final _repository = Repository();

  final _userQuestionResponse = BehaviorSubject<String>();

  Stream<String> get userQuestionResponse => _userQuestionResponse.stream;

  Function(String) get changeUserQuestionResponse => _userQuestionResponse.sink.add;

  Future<void> get signOut => _repository.signOut;
  Future<FirebaseUser> get currentUser => _repository.currentUser;

  Stream<DocumentSnapshot> userDoc(String userUUID) => _repository.userDoc(userUUID);
  Future<QuerySnapshot> getRandomProduct() => _repository.getRandomProduct();

  Future<bool> sendQuestionResponse(String questionResponse, String userUUID, double pointsToAdd) async {
    if(_userQuestionResponse.value == "" || _userQuestionResponse.value == null) {
      // add points and show user message
      changeUserQuestionResponse(questionResponse);
      await _repository.addUserPoints(userUUID, pointsToAdd);
      return true;
    }
    return false;
  }

  String getCurrentMessageResponse() => _userQuestionResponse.value;

  @override
  void dispose() {
    _userQuestionResponse.close();
  }

}