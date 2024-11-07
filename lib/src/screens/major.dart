import 'package:flutter/material.dart';
import '../shared/color.dart';

class MajorPage extends StatefulWidget {
  @override
  MajorPageState createState() => MajorPageState();
}

class MajorPageState extends State<MajorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: primaryColor,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eco Vidrio',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Cuidemos el planeta',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.green),
                      title: Text('Inicio'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/inicio');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.scale, color: Colors.green),
                      title: Text('Peso'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/resultado_peso_page');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.palette, color: Colors.green),
                      title: Text('Color'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/resultado_color_page');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.assessment, color: Colors.green),
                      title: Text('Resultado'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/no_definido_aun');
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Inicio',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 15,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contenedor de Peso
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/resultado_peso_page');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.scale, color: Colors.green, size: 30),
                    SizedBox(width: 15),
                    Text(
                      'Peso',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Contenedor de Color
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/resultado_color_page');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.palette, color: Colors.blue, size: 30),
                    SizedBox(width: 15),
                    Text(
                      'Color',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/resultado_color_page');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.palette, color: Colors.purple, size: 30),
                    SizedBox(width: 15),
                    Text(
                      'Resultado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
