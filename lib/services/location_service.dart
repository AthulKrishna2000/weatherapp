import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/constant.dart' as k;
import 'dart:convert';

class LocationService  {
  // position
  //   to
  // placemark
  // bool? isloaded;
  // num? temp;
  // num? press;
  // num? hum;
  // num? cloudCover;
  // String? cityname;

  Future<Placemark?> geoLocationName(Position? position) async {
    if (position != null) {
      try {
        final placemark = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        if (placemark.isNotEmpty) {
          return placemark[0];
        }
      } catch (e) {
        print("eroor fetichin location : $e");
      }
    }
    return null;
  }

//   getcurrentcityWeather(Position? position) async {
//     var client = http.Client();
//     var uri =
//         '${k.domain}lat=${position?.latitude}&lon=${position?.longitude}&appid=${k.apikey}';

//     // var respon = await client.get(uri as Uri);
//     // if (respon.statusCode == 200) {
//     //   var data = respon.body;
//     //   print(data);
//     // } else {
//     //   print(respon.statusCode);
//     // }
//     print(uri);
//     try {
//       var response = await client.get(Uri.parse(uri)); // Convert String to Uri
//       if (response.statusCode == 200) {
//         var data = response.body;
//         print("ata $data");
//       } else {
//         print(
//             "Failed to fetch weather data. Status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching weather data: $e");
//     } finally {
//       client.close(); // Always close the client to avoid resource leaks.
//     }
//   }
  getcurrentcityWeather(Position? position) async {
    if (position == null) {
      print("Position is null. Cannot fetch weather data.");
      return;
    }

    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apikey}';

    print("Request URI: $uri"); // Debug the constructed URL

    try {
      var response = await client.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var data = response.body;
        var decodedata = json.decode(data);
        print("Weather Data: $data");
        // updateUI(decodedata);
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

  // updateUI(var decodeData) {
    
  //   if (decodeData == null) {
  //     temp = 0;
  //     press = 0;
  //     hum = 0;
  //     cloudCover = 0;
  //     cityname = 'Not availabele';
  //   } else {
  //     temp = decodeData['main']['temp'] - 273;
  //     press = decodeData['main']['pressure'];
  //     hum = decodeData['main']['humidity'];
  //     cloudCover = decodeData['clouds']['all'];
  //     cityname = decodeData['name'];
  //   }
  // }

  // getCUrrentCityName(String cityName) async {
  //   if (cityName == null) {
  //     print("Position is null. Cannot fetch weather data.");
  //     return;
  //   }

  //   var client = http.Client();
  //   var uri = '${k.domain}q=$cityName&appid=${k.apikey}';

  //   print("Request URI: $uri"); // Debug the constructed URL

  //   try {
  //     var response = await client.get(Uri.parse(uri));
  //     if (response.statusCode == 200) {
  //       var data = response.body;
  //       var decodedata = json.decode(data);
  //       print("Weather Data: $data");
  //       updateUI(decodedata);
  //     } else {
  //       print(
  //           "Failed to fetch weather data. Status code: ${response.statusCode}");
  //       print("Response body: ${response.body}"); // Optional: Log response body
  //     }
  //   } catch (e) {
  //     print("Error fetching weather data: $e");
  //   } finally {
  //     client.close();
  //   }
  // }
}
