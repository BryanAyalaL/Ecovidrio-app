import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../shared/styles.dart';
import '../shared/color.dart';
import '../shared/input_fields.dart';
import './signin.dart';
import '../Validaciones/validaciones.dart'; // Importa las validaciones

// Función para registrar un nuevo usuario
Future<bool> registerUser(String email, String password, BuildContext context) async {
  final url = 'http://10.0.2.2:3000/registro'; // URL de la API (para emulador)
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({
    'email': email,
    'contrasena': password,
  });

  try {
    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 201) {
      // Registro exitoso
      print('Usuario registrado exitosamente');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado exitosamente')),
      );
      return true; // Indica éxito
    } else {
      // Manejo de errores
      final responseData = json.decode(response.body);
      final errorMessage = responseData['error']; // Obtener el error del servidor
      print('Error: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $errorMessage')),
      );
      return false; // Indica fallo
    }
  } catch (e) {
    print('Error al conectar con la API: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al conectar con el servidor')),
    );
    return false; // Indica fallo
  }
}

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>(); // Clave para validar el formulario
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Función para validar y enviar el formulario
  void _validateAndSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Si la validación es exitosa, intenta registrar al usuario
      bool success = await registerUser(
        _emailController.text,
        _passwordController.text,
        context,
      );

      // Solo navega si el registro fue exitoso
      if (success) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            alignment: Alignment.center,
            type: PageTransitionType.rightToLeft,
            child: SignInPage(),
          ),
        );
      }
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
                  key: _formKey, // Asociamos el formulario con la clave
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Bienvenido a Eco vidrio', style: h3),
                      Text('Comencemos', style: taglineText),
                      fryoEmailInput(
                        'Correo electrónico',
                        controller: _emailController,
                        validator: (value) {
                          print('Validando email: $value');
                          return InputValidator.validateEmail(value ?? '');
                        },
                      ),
                      fryoPasswordInput(
                        'Contraseña',
                        controller: _passwordController,
                        validator: (value) {
                          print('Validando contraseña: $value');
                          return InputValidator.validatePassword(value ?? '');
                        },
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
