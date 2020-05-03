import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/root_page.dart';
import 'package:megahackdesafioolist/src/utils/values/colors.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = 'splash_page';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 3,
        backgroundColor: OlistColors.colorMainBlue,
        navigateAfterSeconds: RootPage(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_icon.png"),
            fit: BoxFit.none,
          ),
        ),
      ),
    ],
  );
}