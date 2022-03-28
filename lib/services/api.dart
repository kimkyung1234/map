import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';

Future<Tuple2<double, double>> getLocation() async {
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);

  return Tuple2(currentPosition.latitude, currentPosition.longitude);
}
