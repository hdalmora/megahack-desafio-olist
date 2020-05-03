import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/utils/values/colors.dart';

class SecondPageHome extends StatelessWidget {

  final VoidCallback onArrowButtonClick;

  SecondPageHome({
    @required this.onArrowButtonClick
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: OlistColors.colorMainBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80,),
            Image.asset(
              "assets/images/logo_white.png",
              height: 80,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 80.0,),
            Image.asset(
              "assets/images/img_bot_second.png",
              height: 300,
              fit: BoxFit.cover,
            ),

            GestureDetector(
              onTap: onArrowButtonClick,
              child: Container(
                margin: EdgeInsets.only(top: 60.0, right: 10.0),
                alignment: Alignment.centerRight,
                height: 40.0,
                child: Image.asset(
                  "assets/images/arrow_right_green.png",
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
