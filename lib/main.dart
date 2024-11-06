import 'package:flutter/material.dart';
import 'src/screens/signin.dart';
import 'src/screens/singup.dart';
import 'src/screens/welcome_page.dart';
import 'src/screens/dashboard.dart';
import 'src/screens/producto.dart';
import 'src/shared/producto.dart';
import 'src/internal/mysql/mysql_client.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {


  // Instantiate the database
  final db = Database();
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
        '/dashboard': (BuildContext context) => Dashboard(),
        '/productPage': (BuildContext context) => ProductPage(
              productData: Product(),
            ),
      },
    );
  }
}