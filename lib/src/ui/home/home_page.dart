import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/utils/values/colors.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/chat_back.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              color: OlistColors.colorMainBlue,
              child: Row(
                children: <Widget>[

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
