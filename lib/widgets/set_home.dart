import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/db/home_location.dart';
import 'package:map/key.dart';
import 'package:map/models/location.dart';
import 'package:map/providers/map_provider.dart';
import 'package:map/services/api.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SetHomeWidget extends StatelessWidget {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapProvider>(context);
    var locationProvider = Provider.of<HomeLocation>(context);

    return FutureBuilder(
      future: Future.wait([getLocation(), locationProvider.retrieveLocation()]),
      builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        Tuple2<double, double> currentLocation = snapshot.data![0];
        List<Location> homeLocation = snapshot.data![1];

        return Container(
          height: 300,
          margin: const EdgeInsets.all(10),
          child: FlutterMap(
            options: MapOptions(
              onTap: (tapPosition, point) => {
                provider.addPin(LatLng(point.latitude, point.longitude)),
                if (homeLocation.length == 0)
                  {
                    locationProvider.insertLocation(
                        1, point.latitude, point.longitude)
                  }
                else if (homeLocation.length == 1)
                  {
                    locationProvider.updateItem(
                        1, point.latitude, point.longitude)
                  }
              },
              center: homeLocation.length == 0
                  ? LatLng(currentLocation.item1, currentLocation.item2)
                  : LatLng(homeLocation[0].lat, homeLocation[0].lon),
              // center: provider.getHome == null
              //     ? LatLng(currentLocation.item1, currentLocation.item2)
              //     : LatLng(provider.getHome?.item1, provider.getHome?.item2),
              zoom: 10.0,
              minZoom: 3,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=${Keys.mapbox2}',
                additionalOptions: {
                  'accessToken': Keys.mapbox2,
                },
              ),
              MarkerLayerOptions(
                markers: provider.getMarkers,
              ),
            ],
          ),
        );
      },
    );
  }
}
