import 'package:flutter/material.dart';
import 'package:my_weather_app/data/models/detail/daily_item/daily_item.dart';
import 'package:my_weather_app/data/models/helper/lat_lon.dart';
import 'package:my_weather_app/ui/screens/splash/splash_screen.dart';
import 'package:my_weather_app/ui/screens/weather_daily/weather_daily_screen.dart';
import 'package:my_weather_app/ui/screens/weather_main/weather_main_screen.dart';
import 'package:my_weather_app/utils/constants.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return MaterialPageRoute(
            builder: (_) => WeatherMainScreen(
                  latLong: settings.arguments as LatLong,
                ));
      case dailyScreen:
        return MaterialPageRoute(
          builder: (_) => WeatherDailyScreen(
            daily: settings.arguments as List<DailyItem>,
          ),
        );
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
