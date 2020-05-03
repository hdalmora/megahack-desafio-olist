import 'package:flutter/material.dart';
import 'package:megahackdesafioolist/src/root_page.dart';
import 'package:megahackdesafioolist/src/ui/authentication/authentication_page.dart';
import 'package:megahackdesafioolist/src/ui/home/home_page.dart';
import 'package:megahackdesafioolist/src/ui/splash_page.dart';

import 'blocs/authentication/authentication_bloc_provider.dart';
import 'blocs/user/user_bloc_provider.dart';

class OlistBot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthenticationBlocProvider(
      child: UserBlocProvider(
        child: MaterialApp(
            title: 'Olist Bot',
            theme: ThemeData(
              accentColor: Colors.blueAccent,
              fontFamily: 'SF Pro Display',
            ),
            initialRoute: SplashPage.routeName,
            routes: {
              '/': (context) => RootPage(),
              SplashPage.routeName: (context) => SplashPage(),
              RootPage.routeName: (context) => RootPage(),
              AuthenticationPage.routeName: (context) => AuthenticationPage(),
              HomePage.routeName: (context) => HomePage(),
            },
          ),
        ),
    );
  }

}