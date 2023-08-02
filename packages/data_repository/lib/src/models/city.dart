class Weather {
  final String main;
  final String description;
  final String icon;
  Weather(this.main, this.description, this.icon);
}

class City {
  final int id;
  final String name;
  final double temp;
  final double feelsLikeTemp;
  final DateTime sunrise;
  final DateTime sunset;
  final int humidity;
  final double pressure;
  final double tempMax;
  final double tempMin;
  final double wind;
  final Weather weather;

  City({
    required this.id,
    required this.name,
    required this.temp,
    required this.feelsLikeTemp,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.pressure,
    required this.tempMax,
    required this.tempMin,
    required this.wind,
    required this.weather,
  });

  static City empty() => City(
      id: 1,
      name: 'name',
      temp: 2,
      feelsLikeTemp: 3,
      sunrise: DateTime.now(),
      sunset: DateTime.now(),
      humidity: 2,
      pressure: 1,
      tempMax: 1,
      tempMin: 2,
      wind: 1,
      weather: Weather('main', 'description', 'icon'));
}
