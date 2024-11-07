import 'package:flutter/material.dart';

// StatefulWidget para la página de resultado
class ResultadoPagePage extends StatefulWidget {
  @override
  ResultadoPageState createState() => ResultadoPageState();
}

// Estado para la página de resultado
class ResultadoPageState extends State<ResultadoPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
      ),
      body: Center(
        child: Text('Esta es la página de Resultado'),
      ),
    );
  }
}

