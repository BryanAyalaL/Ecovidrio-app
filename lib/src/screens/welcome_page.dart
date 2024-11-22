import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../shared/styles.dart';
import '../shared/color.dart';
import '../shared/botones.dart';
import './singup.dart';
import './signin.dart';

class WelcomePage extends StatefulWidget {
  final String pageTitle;

  const WelcomePage({required this.pageTitle});

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/vidrio.png', width: 130, height: 130),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 0),
            child: Text('Eco-vidrio', style: logoStyle),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(bottom: 0),
            child: froyoTextBtn('Iniciar sesión', () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      alignment: Alignment.center,
                      type: PageTransitionType.rotate,
                      duration: Duration(seconds: 1),
                      child: SignInPage()));
            }),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.all(0),
            child: froyoOutlinedBtn('Registrarse', () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      alignment: Alignment.center,
                      type: PageTransitionType.rotate,
                      duration: Duration(seconds: 1),
                      child: SignUpPage()));
              // Navigator.of(context).pushReplacementNamed('/signup');
            }),
          ),
        ],
      )),
      backgroundColor: bgColor,
    );
  }
}