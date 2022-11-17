import 'package:my_weather_app/data/models/main/weather_model.dart';

// "dt": 1659945600,
// "temp": 29.06,
// "feels_like": 33.44,
// "pressure": 1010,
// "humidity": 73,
// "dew_point": 23.73,
// "uvi": 0.71,
// "clouds": 54,
// "visibility": 10000,
// "wind_speed": 4.81,
// "wind_deg": 232,
// "wind_gust": 8.9,
//"pop": 0.2

class HourlyItem {
  int dt;
  double temp;

  double feelsLike;

  int pressure;

  int humidity;

  double dewPoint;

  double uvi;

  int clouds;

  int visibility;

  double windSpeed;

  int windDeg;

  double windGust;

  List<WeatherModel> weather;

  double pop;

  HourlyItem({
    required this.weather,
    required this.visibility,
    required this.dt,
    required this.clouds,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.feelsLike,
    required this.pop,
    required this.dewPoint,
    required this.uvi,
    required this.windDeg,
    required this.windGust,
    required this.windSpeed,
  });

  factory HourlyItem.fromJson(Map<String, dynamic> json) => HourlyItem(
        weather: (json['weather'] as List<dynamic>?)
                ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        visibility: json['visibility'] as int? ?? 0,
        dt: json['dt'] as int? ?? 0,
        clouds: json['clouds'] as int? ?? 0,
        temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
        pressure: json['pressure'] as int? ?? 0,
        humidity: json['humidity'] as int? ?? 0,
        feelsLike: (json['feels_like'] as num?)?.toDouble() ?? 0.0,
        pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
        dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0.0,
        uvi: (json['uvi'] as num?)?.toDouble() ?? 0.0,
        windDeg: json['wind_deg'] as int? ?? 0,
        windGust: (json['wind_gust'] as num?)?.toDouble() ?? 0.0,
        windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0.0,
      );

  @override
  String toString() {
    return '''
     dt: $dt,
     temp: $temp
     feelsLike: $feelsLike
     pressure: $pressure
     humidity: $humidity
     dew_point: $dewPoint
     uvi: $uvi
     clouds: $clouds
     windSpeed: $windSpeed
     windDeg: $windDeg
     windGust: $windGust
     weather: ${weather.toString()}
    ''';
  }
}
