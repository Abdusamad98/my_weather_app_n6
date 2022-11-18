import 'package:flutter/material.dart';
import 'package:my_weather_app/data/models/detail/one_call_data.dart';
import 'package:my_weather_app/data/models/helper/lat_lon.dart';
import 'package:my_weather_app/data/models/weather_main_model.dart';
import 'package:my_weather_app/data/repository/app_repository.dart';
import 'package:my_weather_app/ui/widgets/my_custom_appbar.dart';
import 'package:my_weather_app/utils/constants.dart';

class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({Key? key, required this.latLong}) : super(key: key);

  final LatLong latLong;

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
  String query = "";
  OneCallData? oneCallData;
  WeatherMainModel? weatherMainModel;

  @override
  void initState() {
    _initialData();
    super.initState();
  }

  _initialData() async {
    try {
      weatherMainModel =
          await AppRepository.getWeatherMainDataByQuery(query: "Olmazor");
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: MyCustomAppBar(
        title: "Weather name",
        onSearchTap: (value) => setState(() {
          query = value;
        }),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            FutureBuilder<WeatherMainModel>(
                future: query.isEmpty
                    ? AppRepository.getWeatherMainDataByLocation(
                        latLong: widget.latLong,
                      )
                    : AppRepository.getWeatherMainDataByQuery(query: query),
                builder: (context, AsyncSnapshot<WeatherMainModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Text("Data: ${data.name}");
                  } else {
                    return Text("Error:${snapshot.error.toString()}");
                  }
                }),
            FutureBuilder<OneCallData>(
              future: AppRepository.getHourlyDailyWeather(latLong: widget.latLong),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (snapshot.hasData) {
                  oneCallData = snapshot.data!;
                  return Column(
                    children: [
                      Text("Data: ${oneCallData!.timezone}"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, dailyScreen,
                              arguments: oneCallData!.daily);
                        },
                        child: const Text(
                          "Daily Weather",
                          style: TextStyle(fontSize: 32),
                        ),
                      )
                    ],
                  );
                } else {
                  return Text("Error:${snapshot.error.toString()}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
