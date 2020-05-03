import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/blocs/authentication/authentication_bloc.dart';
import 'package:megahackdesafioolist/src/blocs/authentication/authentication_bloc_provider.dart';
import 'package:megahackdesafioolist/src/ui/authentication/first_page.dart';
import 'package:megahackdesafioolist/src/ui/authentication/second_page.dart';
import 'package:megahackdesafioolist/src/ui/authentication/third_page.dart';
import 'package:megahackdesafioolist/src/utils/values/colors.dart';

class AuthenticationPage extends StatefulWidget {
  static const String routeName = 'authentication_page';

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  final _pageController = PageController(
    initialPage: 0
  );

  AuthenticationBloc _authBloc;

  @override
  void didChangeDependencies() {
    _authBloc = AuthenticationBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OlistColors.colorMainBlue,
      body: Container(
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            FirstPageHome(
              onGoogleButtonTap: () {
                _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              },
            ),
            SecondPageHome(
              onArrowButtonClick: () {
                _pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              },
            ),
            ThirdPageHome(
              onConsumerButtonClick: () async {
                await _authBloc.authWithGoogle("CONSUMER");
              },
              onSellerButtonClick: () async {
                await _authBloc.authWithGoogle("SELLER");
              },
            ),
          ],
        ),
      ),
    );
  }
}
