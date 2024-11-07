import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../shared/styles.dart';
import '../shared/color.dart';
import '../shared/input_fields.dart';
import './singup.dart';
import 'major.dart';
import '../Validaciones/validaciones.dart';

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validateAndSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          alignment: Alignment.center,
          type: PageTransitionType.rightToLeft,
          child: MajorPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Iniciar sesión',
          style: TextStyle(
              color: Colors.grey, fontFamily: 'Poppins', fontSize: 15),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  alignment: Alignment.center,
                  type: PageTransitionType.rightToLeft,
                  child: SignUpPage(),
                ),
              );
            },
            child: Text('Registrarse', style: contrastText),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 18, right: 18),
            height: 300,
            width: double.infinity,
            decoration: authPlateDecoration,
            child: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Bienvenido de nuevo', style: h3),
                      Text('Hola, vamos a autenticarte', style: taglineText),
                      fryoEmailInput(
                        'Correo electrónico',
                        controller: _emailController,
                        validator: (value) => InputValidator.validateEmail(value ?? ''),
                      ),
                      fryoPasswordInput(
                        'Contraseña',
                        controller: _passwordController,
                        validator: (value) => InputValidator.validatePassword(value ?? ''),
                      ),
                      TextButton(
                        onPressed: () {
                          // Acción para recuperar contraseña
                        },
                        child: Text(
                          '¿Olvidaste la contraseña?',
                          style: contrastTextBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: -15,
                  child: TextButton(
                    onPressed: _validateAndSubmit,
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.all(13),
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
