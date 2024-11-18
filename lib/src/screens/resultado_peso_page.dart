import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Para formatear fechas

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

  // Método para formatear las fechas sin hora, segundos ni zona horaria
  String formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date); // Solo la fecha, sin la hora
    } catch (e) {
      return dateStr; // Si no se puede parsear la fecha, retornamos la cadena original
    }
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
        title: Text('Resultados de Peso'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Muestra un indicador de carga
          : error.isNotEmpty
              ? Center(child: Text(error, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: datos.length,
                  itemBuilder: (context, index) {
                    final item = datos[index];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(15),
                        title: Text(
                          'Trituradora: ${item['trituradora']}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          'Peso: ${item['peso']} kg\n'
                          'Fecha: ${formatDate(item['fecha_inicial'])} - ${formatDate(item['fecha_final'])}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
