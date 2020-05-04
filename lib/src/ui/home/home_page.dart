import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/blocs/user/user_bloc.dart';
import 'package:megahackdesafioolist/src/blocs/user/user_bloc_provider.dart';
import 'package:megahackdesafioolist/src/resources/repository.dart';
import 'package:megahackdesafioolist/src/utils/values/colors.dart';
import 'package:megahackdesafioolist/src/utils/values/constants.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UserBloc _userBloc;

  final _repository = Repository();
  Future<FirebaseUser> _currentUser;
  Future<QuerySnapshot> _randomProduct;

  final _messagesFieldController = TextEditingController();

  String _userUUID;

  @override
  void didChangeDependencies() {
    _userBloc = UserBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _currentUser = _repository.currentUser;
    _randomProduct = _repository.getRandomProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Constants.MediaWidth(context),
        alignment: Alignment.center,
        color: OlistColors.colorMainBlue,
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: _currentUser,
              builder: (context, AsyncSnapshot<FirebaseUser> currentUser) {

                if(!currentUser.hasData || currentUser.connectionState == ConnectionState.waiting) {
                  return LinearProgressIndicator(
                  );
                }

                _userUUID = currentUser.data.uid;
                return StreamBuilder(
                  stream: _userBloc.userDoc(currentUser.data.uid),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                    if(!snapshot.hasData || currentUser.connectionState == ConnectionState.waiting) {
                      return LinearProgressIndicator(
                      );
                    }

                    String userName = snapshot.data["name"];
                    double points = snapshot.data["points"];
                    String profileImageUrl = snapshot.data["profileImageUrl"];
                    String role = snapshot.data["role"];

                    return
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 500.0,
                              height: 130,
                              alignment: Alignment.center,
                              color: OlistColors.colorMainBlue,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withAlpha(150),
                                      offset: Offset(0.0, 0.0), //(x,y)
                                      blurRadius: 10.0,
                                      spreadRadius: 5
                                  ),
                                ],
                              ),
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
                              alignment: Alignment.center,
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
                                                "Fiquei sabendo que você fez a compra desse produto, aqui vai uma pergunta para você sobre ele: ",
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


                                          FutureBuilder(
                                            future: _randomProduct,
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                                                return Flexible(
                                                  flex: 2,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
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

                                                      Container(
                                                        margin: EdgeInsets.only(top: 40.0, left: 20),
                                                        alignment: Alignment.center,
                                                        width: 20,
                                                        height: 20,
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }

                                              if(snapshot.data.documents.length > 0) {
                                                DocumentSnapshot doc = snapshot.data.documents[0];

                                                String productImageUrl = doc.data['imageUrl'];
                                                String productName = doc.data['name'];
                                                String productQuestion = doc.data['question'];

                                                return Flexible(
                                                  flex: 20,
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: 10, bottom: 40.0),
                                                    color: OlistColors.colorMainBlue,
                                                    alignment: Alignment.centerLeft,
                                                    padding: EdgeInsets.all(7.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          flex: 1,
                                                          child: Image(
                                                              width: 100,
                                                              height: 100,
                                                              image: CachedNetworkImageProvider(productImageUrl)),
                                                        ),


                                                        SizedBox(width: 15.0,),
                                                        Flexible(
                                                          flex: 2,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Text(
                                                                productName,
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),

                                                              SizedBox(height: 10.0,),
                                                              Text(
                                                                productQuestion,
                                                                style: TextStyle(
                                                                    color: OlistColors.colorMainYellow,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Flexible(
                                                  flex: 3,
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: 10),
                                                    color: OlistColors.colorMainBlue,
                                                    alignment: Alignment.centerLeft,
                                                    padding: EdgeInsets.all(7.0),
                                                    child: Text(
                                                      "Que pena... Não tenho perguntas disponíveis para hoje :/ ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),

                                        ],
                                      ),
                                    ),


                                    StreamBuilder(
                                      stream: _userBloc.userQuestionResponse,
                                      builder: (context, AsyncSnapshot<String> responseMessage) {
                                        if(!responseMessage.hasData || responseMessage.data == null) {
                                          return Container();
                                        }
                                        return Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 0, left: 25.0),
                                            color: OlistColors.colorMainGreen,
                                            width: 210,
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.all(7.0),
                                            child: Text(
                                              _userBloc.getCurrentMessageResponse(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    StreamBuilder(
                                      stream: _userBloc.userQuestionResponse,
                                      builder: (context, AsyncSnapshot<String> responseMessage) {
                                        if(!responseMessage.hasData || responseMessage.data == null) {
                                          return Container();
                                        }
                                        return Container(
                                          margin: EdgeInsets.only(left: 10.0, bottom: 80),
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
                                                  margin: EdgeInsets.only(top: 10),
                                                  color: OlistColors.colorMainBlue,
                                                  alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.all(7.0),
                                                  child: Text(
                                                    "Boa resposta! acabei de adicionar 10 pontos na sua conta, e enviei para o dono do anúncio validá-la. Quem sabe você não ganha um bônus? *.*",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      },
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

            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                width: 450,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: OlistColors.colorLightGrey,
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(80),
                        offset: Offset(0.0, 0.0), //(x,y)
                        blurRadius: 8.0,
                        spreadRadius: 2
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: TextFormField(
                          controller: _messagesFieldController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Digite sua resposta aqui..."),
                        ),
                      ),
                    ),

                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () async {
                          if(_userUUID != null) {
                            print("send user message with response: add points");
                            print("message text: ${_messagesFieldController.text}");
                            await _userBloc.sendQuestionResponse(_messagesFieldController.text, _userUUID, 10.0);
                            _messagesFieldController.clear();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15.0),
                          child: Icon(Icons.send, size: 25,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
