import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/services/location_service.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/constant.dart' as k;
import 'dart:convert';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;

  Position? get currentPosition => _currentPosition;

  final LocationService _locationService = LocationService();

  Placemark? _currentlocationNmae;

  Placemark? get currentlocationName => _currentlocationNmae;

  Placemark? _currentCityWeather;

  Placemark? get currentCityWeather => _currentCityWeather;

  bool? isloaded;
  num? temp;
  num? tempMax;
  num? tempMin;
  num? press;
  num? hum;
  num? cloudCover;
  String cityname = '';
  String? weather;
  int? sunsetTimestamp;
  int? sunriseTimestamp;
  String? formattedSunrise1;
  String? formattedSunset1;

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      _currentPosition = null;
      notifyListeners();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        _currentPosition = null;
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _currentPosition = null;
      notifyListeners();
      return;
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    print(_currentPosition);

    _currentlocationNmae =
        await _locationService.geoLocationName(_currentPosition);

    print(_currentlocationNmae);
    notifyListeners();

    _currentCityWeather =
        await _locationService.getcurrentcityWeather(_currentPosition);
    print(_currentCityWeather);
  }

  updateUI(var decodeData) {
    if (decodeData == null) {
      temp = 0;
      press = 0;
      hum = 0;
      cloudCover = 0;
      cityname = 'Not availabele';
    } else {
      temp = decodeData['main']['temp'] - 273;
      press = decodeData['main']['pressure'];
      hum = decodeData['main']['humidity'];
      cloudCover = decodeData['clouds']['all'];
      cityname = decodeData['name'];
      weather = decodeData['weather'][0]['main'];
      tempMax = decodeData['main']['temp_min'] - 273;
      tempMin = decodeData['main']['temp_max'] - 273;
      sunriseTimestamp = decodeData['sys']['sunrise'];
      sunsetTimestamp = decodeData['sys']['sunset'];

      DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
          sunriseTimestamp! * 1000); // Convert from seconds to milliseconds
      DateTime sunset =
          DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp! * 1000);
      String formattedSunrise =
          "${sunrise.hour}:${sunrise.minute.toString().padLeft(2, '0')}";
      String formattedSunset =
          "${sunset.hour}:${sunset.minute.toString().padLeft(2, '0')}";

      formattedSunrise1 = formattedSunrise;
      formattedSunset1 = formattedSunset;
    }
    notifyListeners();
  }

  getCUrrentCityName(String cityName) async {
    if (cityName == null) {
      print("Position is null. Cannot fetch weather data.");
      return;
    }

    var client = http.Client();
    var uri = '${k.domain}q=$cityName&appid=${k.apikey}';

    print("Request URI: $uri"); // Debug the constructed URL

    try {
      var response = await client.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var data = response.body;
        var decodedata = json.decode(data);
        print("Weather Data: $data");
        updateUI(decodedata);
      } else {
        print(
            "Failed to fetch weather data. Status code: ${response.statusCode}");
        print("Response body: ${response.body}"); // Optional: Log response body
      }
    } catch (e) {
      print("Error fetching weather data: $e");
    } finally {
      client.close();
    }
  }
}
