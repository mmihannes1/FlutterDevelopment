/* A file for displaying the forcast page
Written by Hannes Lundberg*/

import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class ForecastPage extends StatefulWidget {
  final ForecastModel? forecast;
  const ForecastPage(this.forecast, {super.key});
  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  ForecastModel? _forecast;

  @override
  void initState() {
    super.initState();
    _forecast = widget.forecast;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forecast',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: _forecast == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _forecast!.forecastList.length,
              itemBuilder: (context, index) {
                final item = _forecast!.forecastList[index];
                return ListTile(
                  title: Text("${item.temperature}°C - ${item.description}"),
                  leading: Image.network(item.icon), // Display weather icon
                  subtitle: Text(
                      "${item.getFormattedDate()} ${item.getFormattedTime()}"),
                );
              },
            ),
    );
  }
}
