import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultadoPesoPage extends StatefulWidget {
  @override
  _ResultadoPesoPageState createState() => _ResultadoPesoPageState();
}

class _ResultadoPesoPageState extends State<ResultadoPesoPage> {
  List<dynamic> datos = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    getPeso();
  }

 Future<void> getPeso() async {
  try {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/datos')); // Cambia la IP según tu caso
    if (response.statusCode == 200) {
      setState(() {
        datos = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        error = 'Error: ${response.statusCode}';
        isLoading = false;
      });
    }
  } catch (e) {
    setState(() {
      error = 'Error al conectar al servidor';
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultadosadas Peso'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Muestra un indicador de carga
          : error.isNotEmpty
              ? Center(child: Text(error, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: datos.length,
                  itemBuilder: (context, index) {
                    final item = datos[index];
                    return ListTile(
                      title: Text('Trituradora: ${item['trituradora']}'),
                      subtitle: Text(
                          'Peso: ${item['peso']}, Fecha: ${item['fecha_inicial']} - ${item['fecha_final']}'),
                    );
                  },
                ),
    );
  }
}
