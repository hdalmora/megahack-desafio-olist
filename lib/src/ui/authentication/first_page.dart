import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/utils/values/colors.dart';
import 'package:megahackdesafioolist/src/utils/values/constants.dart';

class FirstPageHome extends StatelessWidget {

  final VoidCallback onGoogleButtonTap;

  FirstPageHome({
    @required this.onGoogleButtonTap
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 190,
          left: 0,
          child: Container(
            height: 270,
            width: MediaQuery.of(context).size.width*1.23,
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white, Colors.white70],
              ),
            ),
          ),
        ),

        Column(
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
              "assets/images/img_bot_first_blue.png",
              height: 200,
              fit: BoxFit.cover,
            ),


            SizedBox(height: 60.0,),
            Container(
              alignment: Alignment.center,
              child: Text(
                "A olist ajuda quem quer vender a encontrar quem quer comprar, e eu estou aqui para simplificarainda mais esse processo ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),

            GestureDetector(
              onTap: onGoogleButtonTap,
              child: Container(
                margin: EdgeInsets.only(top: 60.0, left: 30, right: 30),
                width: Constants.MediaScreenBreakpoint(context) ? Constants.MediaWidth(context)*.20 : Constants.MediaWidth(context)*.45,
                alignment: Alignment.center,
                height: 70.0,
                decoration: BoxDecoration(
                    color: OlistColors.colorMainYellow,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                child: Text(
                  "ENTRAR COM O GOOGLE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
