import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:map/key.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:tuple/tuple.dart';

Future<Tuple2<double, double>> getLocation() async {
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);

  return Tuple2(currentPosition.latitude, currentPosition.longitude);
}

Future<List<MapBoxPlace>?> recommendPlace() async {
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);

  var geoCodingService = ReverseGeoCoding(
    apiKey: Keys.mapbox2,
    limit: 10,
  );

  var addresses = geoCodingService.getAddress(
    Location(
      lat: currentPosition.latitude,
      lng: currentPosition.longitude,
    ),
  );

  return addresses;
}
