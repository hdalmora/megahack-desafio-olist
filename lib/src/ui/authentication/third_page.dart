import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/utils/values/colors.dart';
import 'package:megahackdesafioolist/src/utils/values/constants.dart';

class ThirdPageHome extends StatelessWidget {

  final VoidCallback onConsumerButtonClick;
  final VoidCallback onSellerButtonClick;

  ThirdPageHome({
    @required this.onConsumerButtonClick,
    @required this.onSellerButtonClick
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

            SizedBox(height: 60.0,),
            Image.asset(
              "assets/images/img_bot_third.png",
              height: 300,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 30.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onSellerButtonClick,
                    child: Container(
                      width: Constants.MediaScreenBreakpoint(context) ? Constants.MediaWidth(context)*.20 : Constants.MediaWidth(context)*.45,
                      margin: EdgeInsets.only(top: 35.0, right: 10.0, left: 10),
                      alignment: Alignment.center,
                      height: 70.0,
                      decoration: BoxDecoration(
                          color: OlistColors.colorMainGrey,
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                      child: Text(
                        "VENDEDOR",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),

                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onConsumerButtonClick,
                    child: Container(
                      width: Constants.MediaScreenBreakpoint(context) ? Constants.MediaWidth(context)*.20 : Constants.MediaWidth(context)*.45,
                      margin: EdgeInsets.only(top: 35.0, left: 10.0, right: 10),
                      alignment: Alignment.center,
                      height: 70.0,
                      decoration: BoxDecoration(
                          color: OlistColors.colorMainYellow,
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                      child: Text(
                        "CONSUMIDOR",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
