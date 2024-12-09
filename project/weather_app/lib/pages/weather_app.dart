/*A file for initiating the API call and also display the app as a whole
Written by Hannes Lunderg*/

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'forecast.dart';
import 'about.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final String _apiKey = dotenv.env['API_KEY']!;
  late final weatherService _weatherService;
  Weather? _weather;
  ForecastModel? _forecast;

  @override
  void initState() {
    super.initState();

    _weatherService = weatherService(_apiKey);

    _fetchWeather();
  }

  _fetchWeather() async {
    try {
      var status = await Permission.location.status;
      if (status.isDenied) {
        status = await Permission.location.request();
        if (status.isDenied) {
          throw Exception('Location permissions are denied');
        }
      }

      final location = await _weatherService.getLocation();
      final weather = await _weatherService.getWeather(location!);
      final forecast = await _weatherService.getForecast(location);

      setState(() {
        _weather = weather;
        _forecast = forecast;
      });
    } catch (e) {
      Error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Scaffold(
            body: Center(
              child: _weather == null
                  ? const Text('Loading...')
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${_weather?.cityName}',
                            style: const TextStyle(fontSize: 50)),
                        if (_weather?.icon != null)
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              '${_weather!.icon}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        if (_weather?.icon == null)
                          const Text('No icon available'),
                        Text(
                            '${_weather?.temperature.toString().substring(0, 2)}°C',
                            style: const TextStyle(fontSize: 40)),
                        Text('${_weather?.description}',
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ),
            ),
          ),
          ForecastPage(_forecast),
          const About(),
        ],
      ),
    );
  }
}
