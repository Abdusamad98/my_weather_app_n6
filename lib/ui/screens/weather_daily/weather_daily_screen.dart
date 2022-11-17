import 'package:flutter/material.dart';
import 'package:my_weather_app/data/models/detail/daily_item/daily_item.dart';

class WeatherDailyScreen extends StatefulWidget {
  const WeatherDailyScreen({Key? key, required this.daily}) : super(key: key);

  final List<DailyItem> daily;

  @override
  State<WeatherDailyScreen> createState() => _WeatherDailyScreenState();
}

class _WeatherDailyScreenState extends State<WeatherDailyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
    );
  }
}
