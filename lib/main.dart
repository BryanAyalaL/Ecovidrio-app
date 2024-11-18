import 'dart:convert';

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
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> users = [];

  // Método para obtener usuarios desde la API
  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://localhost:3000/usuarios'));

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, decodificamos el JSON
      setState(() {
        users = json.decode(response.body);
      });
    } else {
      // Si hay un error, muestra un mensaje
      throw Exception('Error al cargar los usuarios');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();  // Llamamos a la función para obtener los usuarios al iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuarios"),
      ),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Ciudad: ${users[index]['nombre_ciudad']}'),
                );
              },
            ),
    );
  }
}
*/

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