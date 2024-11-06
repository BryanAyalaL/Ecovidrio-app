import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../shared/styles.dart';
import '../shared/color.dart';
import '../shared/input_fields.dart';
import './signin.dart';
import './dashboard.dart';
import '../Validaciones/validaciones.dart'; // Importa las validaciones

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>(); // Añadido para validar el formulario
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validateAndSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Si la validación es exitosa, navega al Dashboard
      Navigator.pushReplacement(
        context,
        PageTransition(
          alignment: Alignment.center,
          type: PageTransitionType.rightToLeft,
          child: Dashboard(),
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
        title: Text('Registrarse',
            style: TextStyle(color: Colors.grey, fontFamily: 'Poppins', fontSize: 15)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  alignment: Alignment.center,
                  type: PageTransitionType.rightToLeft,
                  child: SignInPage(),
                ),
              );
            },
            child: Text('Iniciar sesión', style: contrastText),
          ),
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
                  key: _formKey, // Asocia el formulario con la clave
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Bienvenido a Eco vidrio!', style: h3),
                      Text('Comencemos', style: taglineText),
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
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: -15,
                  child: TextButton(
                    onPressed: _validateAndSubmit, // Valida antes de enviar
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.all(13),
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.arrow_forward, color: white),
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
