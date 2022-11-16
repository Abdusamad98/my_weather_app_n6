import 'package:flutter/material.dart';

class WeatherDetailScreen extends StatefulWidget {
  const WeatherDetailScreen({Key? key}) : super(key: key);

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail"),),
    );
  }
}
