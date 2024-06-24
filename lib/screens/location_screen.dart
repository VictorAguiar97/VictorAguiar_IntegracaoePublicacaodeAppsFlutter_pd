import 'package:auto_control_panel/models/location.dart';
import 'package:auto_control_panel/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar datas

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.pinkAccent,
        title: const Text('Informações de Localização'),
      ),
      body: FutureBuilder<Location>(
        future:
            LocationService.getLocation(-23.467869902905825, -46.2500249977259),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Dados não encontrados'));
          } else {
            Location location = snapshot.data!;
            String weatherDescription = location.description;
            String locationInfo =
                'Latitude: ${location.latitude}, Longitude: ${location.longitude}';
            String weather =
                'Clima: $weatherDescription, Mínima: ${location.temperatureMin}°C, Máxima: ${location.temperatureMax}°C';
            String cityName = location.name;
            String country = location.country;

            String time = DateFormat('HH:mm').format(DateTime.now());

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Localização:",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    locationInfo,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Clima:",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    weather,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Cidade:",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '$cityName, $country',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Horário:",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
