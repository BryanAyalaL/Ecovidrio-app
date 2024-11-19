import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

// Modelo de Resultado
class Resultado {
  final double peso;
  final String color;
  final String hora;
  final String fecha;
  final String maquina;

  Resultado({
    required this.peso,
    required this.color,
    required this.hora,
    required this.fecha,
    required this.maquina,
  });

  factory Resultado.fromJson(Map<String, dynamic> json) {
    return Resultado(
      peso: json['peso'] is String
          ? double.parse(json['peso'])
          : (json['peso'] ?? 0).toDouble(),
      color: json['color'] ?? '',
      hora: json['hora'] ?? '',
      fecha: json['fecha'] ?? '',
      maquina: json['maquina'] ?? '',
    );
  }
}

// Función para consumir la API
Future<List<Resultado>> fetchResultados() async {
  final url = Uri.parse('http://10.0.2.2:3000/resultado'); // Cambia por tu URL real
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((item) => Resultado.fromJson(item)).toList();
  } else {
    throw Exception('Error al cargar los resultados');
  }
}

// Función para formatear la fecha
String formatFecha(String fecha) {
  try {
    DateTime fechaParseada = DateTime.parse(fecha);
    return DateFormat('dd MMM yyyy').format(fechaParseada); // Formato "dd MMM yyyy"
  } catch (e) {
    return fecha;
  }
}

// Calcular los porcentajes por color
Map<String, double> calcularPorcentajes(List<Resultado> resultados) {
  final Map<String, double> conteoColores = {};
  for (var resultado in resultados) {
    if (resultado.color.isNotEmpty) {
      conteoColores[resultado.color] = (conteoColores[resultado.color] ?? 0) + 1;
    }
  }

  final total = conteoColores.values.reduce((a, b) => a + b);
  return conteoColores.map((color, count) => MapEntry(color, (count / total) * 100));
}

// Widget para el gráfico de barras de peso
class PesoBarChart extends StatelessWidget {
  final List<Resultado> resultados;

  PesoBarChart({required this.resultados});

  @override
  Widget build(BuildContext context) {
    if (resultados.isEmpty) {
      return Center(child: Text('No hay datos disponibles para mostrar.'));
    }

    List<BarChartGroupData> barData = resultados
        .where((resultado) => resultado.peso > 0)
        .toList()
        .map((resultado) {
          final index = resultados.indexOf(resultado);
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: resultado.peso,
                color: Colors.teal, // Color de las barras
                width: 18,
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
              ),
            ],
          );
        }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: resultados.map((r) => r.peso).reduce((a, b) => a > b ? a : b) + 5,
          barGroups: barData,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Se desactivó la visualización del eje Y
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() < resultados.length) {
                    return Text(
                      formatFecha(resultados[value.toInt()].fecha), // Usamos la fecha formateada
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal),
                    );
                  }
                  return Text('');
                },
                interval: 1,
                reservedSize: 30, // Espacio extra para las fechas en el eje X
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true, drawVerticalLine: false), // Mejorar la cuadrícula
        ),
      ),
    );
  }
}

// Widget para el gráfico de pastel
class ColorPieChart extends StatelessWidget {
  final Map<String, double> porcentajes;

  ColorPieChart({required this.porcentajes});

  @override
  Widget build(BuildContext context) {
    if (porcentajes.isEmpty) {
      return Center(child: Text('No hay colores disponibles para mostrar.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          sections: porcentajes.entries.map((entry) {
            final color = _colorFromString(entry.key);
            return PieChartSectionData(
              value: entry.value,
              title: '${entry.value.toStringAsFixed(1)}%',
              color: color,
              radius: 50,
              titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            );
          }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  // Función para convertir nombres de colores a objetos de Color
  Color _colorFromString(String colorName) {
    final colorMap = {
      'rojo': Colors.red,
      'azul': Colors.blue,
      'verde': Colors.green,
      'amarillo': Colors.yellow,
      'morado': Colors.purple,
      'naranja': Colors.orange,
    };
    return colorMap[colorName.toLowerCase()] ?? Colors.grey;
  }
}

// Página principal que integra todo
class ResultadoPage extends StatefulWidget {
  @override
  _ResultadoPageState createState() => _ResultadoPageState();
}

class _ResultadoPageState extends State<ResultadoPage> {
  late Future<List<Resultado>> _resultados;

  @override
  void initState() {
    super.initState();
    _resultados = fetchResultados(); // Llamada a la API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados', style: TextStyle(fontWeight: FontWeight.normal)),
        backgroundColor: Colors.transparent, // Fondo transparente
        elevation: 0, // Sin sombra
      ),
      body: FutureBuilder<List<Resultado>>(
        future: _resultados,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
          }

          final resultados = snapshot.data!;
          final coloresValidos = resultados.where((r) => r.color.isNotEmpty).toList();
          final porcentajes = calcularPorcentajes(coloresValidos);

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Diagrama de Peso',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: PesoBarChart(resultados: resultados),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Distribución por Color',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ColorPieChart(porcentajes: porcentajes),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ResultadoPage(),
  ));
}
