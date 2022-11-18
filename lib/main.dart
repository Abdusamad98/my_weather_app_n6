import 'package:flutter/material.dart';
import 'package:my_weather_app/ui/routes.dart';
import 'package:my_weather_app/ui/screens/weather_main/weather_main_screen.dart';
import 'package:my_weather_app/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => MyRouter.generateRoute(settings),
      initialRoute: splashScreen,
    );
  }
}
