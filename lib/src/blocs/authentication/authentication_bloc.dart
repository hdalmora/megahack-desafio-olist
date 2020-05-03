import 'package:megahackdesafioolist/src/blocs/bloc.dart';
import 'package:megahackdesafioolist/src/resources/repository.dart';

class AuthenticationBloc implements Bloc {
  final _repository = Repository();

  Future<int> authWithGoogle(String role) => _repository.signInWithGoogle(role);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}