import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/data/models/helper/lat_lon.dart';
import 'package:my_weather_app/data/models/weather_main_model.dart';
import 'package:my_weather_app/data/repository/app_repository.dart';

class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({Key? key}) : super(key: key);

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
  bool isLoaded = false;
  LatLong? latLong;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (_locationData.latitude != null) {
      setState(() {
        isLoaded = true;
      });
      latLong = LatLong(
        lat: _locationData.latitude!,
        long: _locationData.longitude!,
      );
    }

    print("LONGITUDE:${_locationData.longitude} AND ${_locationData.latitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather main"),
      ),
      body: Column(
        children: [
          FutureBuilder<WeatherMainModel>(
              future: AppRepository.getWeatherMainDataByQuery(
                query: "Olmazor",
              ),
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
          if (latLong != null)
            FutureBuilder<WeatherMainModel>(
                future: AppRepository.getWeatherMainDataByLocation(
                  latLong: latLong!,
                ),
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
          Visibility(
            visible: isLoaded == false,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
