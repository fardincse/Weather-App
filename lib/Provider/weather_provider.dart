import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/Models/data_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class FetchData with ChangeNotifier {
  DataModel? _weather;
  DataModel? get weather => _weather;
  late String longtitute;
  late String latitute;
  bool isLoading = false;

  Future<void> fetchWeather() async {
    isLoading = true;
    notifyListeners();
    try {
      await fetchLocation();
      await fetchData();
    } catch (e) {
      print('Error = $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Fluttertoast.showToast(msg: "Your Location Service is off");
        throw Exception('Location services are disabled');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: "Location Permission is denied");
          throw Exception('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: "Location Permission is denied forever");
        throw Exception('Location permission denied forever');
      } else {
        Position position = await Geolocator.getCurrentPosition();
        longtitute = position.longitude.toString();
        latitute = position.latitude.toString();
      }
    } catch (e) {
      longtitute = '91.1000';
      latitute = '22.8167';
    }
  }

  Future<void> fetchData() async {
    String baseUrl = 'http://api.weatherapi.com/v1/forecast.json?';
    String key = 'key=72e7e4f689134be0b3640336252309';
    String days = '&days=7';
    String address = '&q=$latitute,$longtitute';
    final response = await http.get(Uri.parse('$baseUrl$key$address$days'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
    final jsonData = jsonDecode(response.body);
    _weather = DataModel.fromJson(jsonData);
    notifyListeners();
  }
}
