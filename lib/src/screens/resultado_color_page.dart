import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Para formatear fecha y hora

class ResultadoColorPage extends StatefulWidget {
  @override
  _ResultadoColorPageState createState() => _ResultadoColorPageState();
}

class _ResultadoColorPageState extends State<ResultadoColorPage> {
  List<dynamic> datos = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/color')); // Cambia la URL si es necesario
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

  // Formatea la fecha para que solo muestre el año, mes y día
  String formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date); // Formato deseado
    } catch (e) {
      return dateStr; // Si falla, devuelve la fecha original
    }
  }

  // Formatea la hora para que solo muestre horas y minutos
  String formatTime(String timeStr) {
    try {
      DateTime time = DateTime.parse("1970-01-01 $timeStr"); // Usa una fecha arbitraria
      return DateFormat('HH:mm').format(time); // Formato deseado
    } catch (e) {
      return timeStr; // Si falla, devuelve la hora original
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado Color'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: datos.where((item) => item['color'] != null).length,
                  itemBuilder: (context, index) {
                    // Filtra los registros donde 'color' no sea null
                    final filteredData = datos.where((item) => item['color'] != null).toList();
                    final item = filteredData[index];

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
                          'Hora: ${formatTime(item['hora'])}\n'
                          'Color: ${item['color']}\n'
                          'Fecha: ${formatDate(item['fecha'])}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
