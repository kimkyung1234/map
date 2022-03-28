import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tuple/tuple.dart';

class MapProvider with ChangeNotifier {
  Tuple2? home;
  Tuple2? get getHome => home;

  void setHome(Tuple2 location) {
    home = location;
    notifyListeners();
  }

  List<Marker> markers = [];
  List<Marker> get getMarkers => markers;

  addPin(LatLng latlng) {
    markers.clear();
    markers.add(Marker(
      width: 30.0,
      height: 30.0,
      point: latlng,
      builder: (ctx) => const Icon(
        Icons.place,
        color: Colors.red,
        size: 35,
      ),
    ));
    home = Tuple2(latlng.latitude, latlng.longitude);
    notifyListeners();
  }
}
