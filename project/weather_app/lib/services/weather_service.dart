/*A file for getting data form the API and handling permissions regarding teh devices position
Written by Hannes Lundberg */

import 'dart:convert';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class weatherService {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';
  final String apiKey;

  weatherService(this.apiKey);

  Future<Weather> getWeather(Position coodrinates) async {
    final lat = coodrinates.latitude;
    final lon = coodrinates.longitude;
    final url = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to load weather data; status code: ${response.statusCode}');
    }
  }

  Future<ForecastModel> getForecast(Position coodrinates) async {
    final lat = coodrinates.latitude;
    final lon = coodrinates.longitude;

    final url = '$forecastUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to load forecast data; status code: ${response.statusCode}');
    }
  }

  Future<Position?> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
