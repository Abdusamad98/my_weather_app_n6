import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/data/models/helper/lat_lon.dart';
import 'package:my_weather_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, mainScreen,
          arguments: LatLong(
            lat: _locationData.latitude!,
            long: _locationData.longitude!,
          ));
    }

    print("LONGITUDE:${_locationData.longitude} AND ${_locationData.latitude}");
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash screen "),
      ),
    );
  }
}
