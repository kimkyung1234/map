import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/key.dart';
import 'package:map/providers/map_provider.dart';
import 'package:map/services/api.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SetHomeWidget extends StatelessWidget {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapProvider>(context);

    return FutureBuilder<Tuple2<double, double>>(
      future: getLocation(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          height: 300,
          margin: const EdgeInsets.all(10),
          child: FlutterMap(
            // mapController: mapController,
            options: MapOptions(
              onTap: (tapPosition, point) => {
                provider.addPin(LatLng(point.latitude, point.longitude)),
              },
              center: provider.getHome == null
                  ? LatLng(snapshot.data!.item1, snapshot.data!.item2)
                  : LatLng(provider.getHome?.item1, provider.getHome?.item2),
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
