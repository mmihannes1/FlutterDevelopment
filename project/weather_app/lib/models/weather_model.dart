/*A file for handling JSON data recived form the API
Written by Hannes Lundberg*/

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final icon;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.description,
      required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'],
        description: json['weather'][0]['description'],
        icon:
            'https://openweathermap.org/img/w/${json['weather'][0]['icon']}.png');
  }
}

class ForecastModel {
  final String cityName;
  final List<ForecastItems> forecastList;
  ForecastModel({required this.cityName, required this.forecastList});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    List<ForecastItems> forecastList = (json['list'] as List).map((item) {
      return ForecastItems.fromJson(item);
    }).toList();

    return ForecastModel(
      cityName: json['city']['name'],
      forecastList: forecastList,
    );
  }
}

class ForecastItems {
  final DateTime date;
  final String description;
  final dynamic temperature;
  final icon;

  ForecastItems(
      {required this.date,
      required this.description,
      required this.temperature,
      required this.icon});

  factory ForecastItems.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['dt_txt']);
    return ForecastItems(
        date: dateTime,
        description: json['weather'][0]['description'],
        temperature: json['main']['temp'],
        icon:
            'https://openweathermap.org/img/w/${json['weather'][0]['icon']}.png');
  }

  String getFormattedTime() {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String getFormattedDate() {
    return '${date.day}/${date.month}';
  }
}
