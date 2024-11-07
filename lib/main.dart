import 'package:flutter/material.dart';
import '/src/screens/resultado_page.dart';
import 'src/screens/resultado_color_page.dart';
import 'src/screens/resultado_peso_page.dart';
import 'src/screens/signin.dart';
import 'src/screens/singup.dart';
import 'src/screens/welcome_page.dart';
import 'src/screens/major.dart';
import 'src/screens/producto.dart';
import 'src/shared/producto.dart';
//import 'src/internal/mysql/mysql_client.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {


  // Instantiate the database
  //final db = Database();
/* 

  await db.connect();

  
  await db.executeQuery(
      'update users set age=? where name=?', [26, 'Bob']);


  await db.closeConnection();
*/
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
        '/inicio': (BuildContext context) => MajorPage(),
        '/productPage': (BuildContext context) => ProductPage(productData: Product()),
        '/resultado_peso_page': (BuildContext context) => ResultadoPesoPage(),
        '/resultado_color_page': (BuildContext context) => ResultadoColorPage(),
        '/resultado_page': (BuildContext context) => ResultadoPage(),
      },
    );
  }
}