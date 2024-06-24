class Location {
  double latitude;
  double longitude;
  String description;
  double temperature;
  double temperatureMin;
  double temperatureMax;
  String name;
  String country;

  Location({
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.name,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['coord']['lat'].toDouble(),
      longitude: json['coord']['lon'].toDouble(),
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      temperatureMin: json['main']['temp_min'].toDouble(),
      temperatureMax: json['main']['temp_max'].toDouble(),
      name: json['name'],
      country: json['sys']['country'],
    );
  }
}
