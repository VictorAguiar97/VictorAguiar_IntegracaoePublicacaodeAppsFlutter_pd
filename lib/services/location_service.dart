import 'dart:convert';
import 'package:auto_control_panel/models/location.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = 'c2ae641bee0f88af6332e4ce0d1c6b0f';
  static const String _units = 'metric';
  static const String _lang = 'pt_br';

  static Future<Location> getLocation(double latitude, double longitude) async {
    Uri uri = Uri.parse(
        '$_baseUrl?lat=$latitude&lon=$longitude&appid=$_apiKey&units=$_units&lang=$_lang');

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        return Location.fromJson(json);
      } else {
        throw Exception('Falha ao carregar dados da API');
      }
    } catch (e) {
      throw Exception('Erro na requisição HTTP: $e');
    }
  }
}
