import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../shared/styles.dart';
import '../shared/color.dart';
import '../shared/input_fields.dart';
import './singup.dart';
import 'major.dart';
import '../Validaciones/validaciones.dart';

// Función para registrar un nuevo usuario
Future<void> registerUser(String email, String password, BuildContext context) async {
  final url = 'http://10.0.2.2:3000/registro';  // URL de la API (para emulador)
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
    } else {
      // Manejo de errores
      final responseData = json.decode(response.body);
      print('Error: ${responseData['error']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${responseData['error']}')),
      );
    }
  } catch (e) {
    print('Error al conectar con la API: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al conectar con el servidor')),
    );
  }
}

// Función para iniciar sesión
Future<void> loginUser(String email, String password, BuildContext context) async {
  final url = 'http://10.0.2.2:3000/login';  // URL de la API

  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({
    'email': email,
    'contrasena': password,
  });

  try {
    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final message = responseData['message']; // Obtén el mensaje de la respuesta
      final userId = responseData['userId']; // Obtén el userId si es necesario

      // Mostrar el mensaje de éxito y navegar
      print('Inicio de sesión exitoso: $message');
      Navigator.pushReplacement(
        context,
        PageTransition(
          alignment: Alignment.center,
          type: PageTransitionType.rightToLeft,
          child: MajorPage(),  // Redirigir a la página principal
        ),
      );
    } else {
      final responseData = json.decode(response.body);
      final errorMessage = responseData['error'];  // Obtener el error de la respuesta
      print('Error: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    }
  } catch (e) {
    print('Error al conectar con la API: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error al conectar con el servidor.'),
    ));
  }
}

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Función para validar y enviar el formulario
  void _validateAndSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Si la validación es exitosa, inicia sesión
      await loginUser(_emailController.text, _passwordController.text, context);
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
          style: TextStyle(color: Colors.grey, fontFamily: 'Poppins', fontSize: 15),
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
                    
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: -15,
                  child: TextButton(
                    onPressed: _validateAndSubmit,  // Valida antes de enviar
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
