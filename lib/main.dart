import 'package:flutter/material.dart';
import 'src/screens/signin.dart';
import 'src/screens/singup.dart';
import 'src/screens/welcome_page.dart';
import 'src/screens/dashboard.dart';
import 'src/screens/producto.dart';
import 'src/shared/producto.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco vidrio',
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de depuración
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: WelcomePage(pageTitle: 'Welcome'),
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => SignUpPage(),
        '/signin': (BuildContext context) => SignInPage(),
        '/dashboard': (BuildContext context) => Dashboard(),
        '/productPage': (BuildContext context) => ProductPage(
              productData: Product(),
            ),
      },
    );
  }
}