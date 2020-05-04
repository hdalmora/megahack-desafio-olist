import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/blocs/user/user_bloc.dart';
import 'package:megahackdesafioolist/src/blocs/user/user_bloc_provider.dart';
import 'package:megahackdesafioolist/src/utils/values/colors.dart';
import 'package:megahackdesafioolist/src/utils/values/constants.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UserBloc _userBloc;

  @override
  void didChangeDependencies() {
    _userBloc = UserBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Constants.MediaWidth(context),
        color: OlistColors.colorMainBlue,
        child: FutureBuilder(
          future: _userBloc.currentUser,
          builder: (context, AsyncSnapshot<FirebaseUser> currentUser) {

            if(!currentUser.hasData || currentUser.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator(
              );
            }
            return StreamBuilder(
              stream: _userBloc.userDoc(currentUser.data.uid),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                if(!snapshot.hasData || currentUser.connectionState == ConnectionState.waiting) {
                  return LinearProgressIndicator(
                  );
                }

                String userName = snapshot.data["name"];
                double    points = snapshot.data["points"];
                String profileImageUrl = snapshot.data["profileImageUrl"];
                String role = snapshot.data["role"];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 500.0,
                      height: 130,
                      color: OlistColors.colorMainYellow,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20.0),
                                child: Image.asset(
                                  "assets/images/logo_white.png",
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.all(7.0),
                                margin: EdgeInsets.only(left: 10.0),
                                color: OlistColors.colorMainGreen,
                                child: Text(
                                  "$points Pontos",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 20.0),
                                    child: profileImageUrl != null ?
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(32.0),
                                        child: Image(
                                            width: 50,
                                            height: 50,
                                            image: CachedNetworkImageProvider(profileImageUrl)),
                                        )
                                        : Image.asset(
                                      "assets/images/user_icon.png",
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () async {
                                      await _userBloc.signOut;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20.0),
                                      child: Icon(
                                        Icons.exit_to_app,
                                        size: 32.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                              Container(
                                margin: EdgeInsets.only(top: 15.0, right: 5.0),
                                child: Text(
                                  userName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 500,
                      height: Constants.MediaHeight(context)*0.83,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(150),
                              offset: Offset(0.0, 15.0), //(x,y)
                              blurRadius: 10.0,
                              spreadRadius: 5
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage("assets/images/chat_back.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: Image.asset(
                                        "assets/images/bot_icon.png",
                                        height: 45,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),


                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      color: OlistColors.colorMainBlue,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(7.0),
                                      child: Text(
                                        "OOiii!! Eu sou o Olistin, o seu parceiro dos marketplaces :D",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: Image.asset(
                                        "assets/images/bot_icon.png",
                                        height: 45,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),


                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      color: OlistColors.colorMainBlue,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(7.0),
                                      child: Text(
                                        "Eu vou ser o responsável por facilitar toda a comunicação com os donos dos produtos que você esteja interessado, e recomendar alguns produtos que eu sei que você vai gostar também!!",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: Image.asset(
                                        "assets/images/bot_icon.png",
                                        height: 45,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),


                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      color: OlistColors.colorMainBlue,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(7.0),
                                      child: Text(
                                        "Falando nisso, também sou seu canal direto para que possa ajudar os vendedores! Sim, vou selecionar uma série de dúvidas de outras pessoas e compartilhar aqui contigo. Se você me responder, e eu achar uma resposta legal, vou mandar ela para o dono do produto validar.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: Image.asset(
                                        "assets/images/bot_icon.png",
                                        height: 45,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),


                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      color: OlistColors.colorMainBlue,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(7.0),
                                      child: Text(
                                        "Aqui vai uma pergunta para você: ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 5,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: Image.asset(
                                        "assets/images/bot_icon.png",
                                        height: 45,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),


                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      color: OlistColors.colorMainBlue,
                                      alignment: Alignment.topCenter,
                                      padding: EdgeInsets.all(0.0),
                                      child: Text(
                                        ". . .",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                    ),
                  ],
                );
              },
            );

          },
        ),
      ),
    );
  }
}
