import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/key.dart';
import 'package:map/widgets/common.dart';
import 'package:mapbox_search/mapbox_search.dart';

class ShowPage extends StatelessWidget {
  final MapBoxPlace data;
  const ShowPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          data.text ?? '',
          style: const TextStyle(color: Colors.black),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: BackButton(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: FlutterMap(
              options: MapOptions(
                onTap: (tapPosition, point) => {
                  print(point.toString()),
                },
                center: LatLng(data.center![1], data.center![0]),
                zoom: 16.0,
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
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(data.center![1], data.center![0]),
                      builder: (ctx) => const Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          flexibleText(
            text: data.placeName ?? '',
            fontWeight: FontWeight.bold,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
          ),
          flexibleText(text: data.properties!.wikidata ?? ''),
        ],
      ),
    );
  }
}
