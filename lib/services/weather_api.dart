import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:map/key.dart';
import 'package:map/models/weather_model.dart';

Future<Weather> getCurrentWeatherData() async {
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);

  Response response = await get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${currentPosition.latitude}&lon=${currentPosition.longitude}&appid=${Keys.openWeather}&units=metric'));

  return Weather.fromJson(jsonDecode(response.body));
}
