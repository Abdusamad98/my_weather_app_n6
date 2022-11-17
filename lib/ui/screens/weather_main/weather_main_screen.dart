import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/data/models/detail/one_call_data.dart';
import 'package:my_weather_app/data/models/helper/lat_lon.dart';
import 'package:my_weather_app/data/models/weather_main_model.dart';
import 'package:my_weather_app/data/repository/app_repository.dart';
import 'package:my_weather_app/ui/widgets/my_custom_appbar.dart';
import 'package:my_weather_app/ui/widgets/search_delegate_view.dart';
import 'package:my_weather_app/utils/constants.dart';
import 'package:my_weather_app/utils/my_utils.dart';

class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({Key? key}) : super(key: key);

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
  bool isLoaded = false;
  LatLong? latLong;
  String query = "";
  OneCallData? oneCallData;

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
      backgroundColor: Colors.yellow,
      // appBar: MyCustomAppBar(
      //   title: "Weather name",
      //   onSearchTap: () async {
      //     var searchText = await showSearch(
      //       context: context,
      //       delegate:
      //           SearchDelegateView(suggestionList: MyUtils.getPlaceNames()),
      //     );
      //     setState(() {
      //       query = searchText;
      //     });
      //     print("RESULTTTTT:$searchText");
      //   },
      // ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            if (latLong != null)
              FutureBuilder<WeatherMainModel>(
                  future: query.isEmpty
                      ? AppRepository.getWeatherMainDataByLocation(
                          latLong: latLong!)
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
            Visibility(
              visible: isLoaded == false,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            if (latLong != null)
              FutureBuilder<OneCallData>(
                  future:
                      AppRepository.getHourlyDailyWeather(latLong: latLong!),
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
                  }),
          ],
        ),
      ),
    );
  }
}
