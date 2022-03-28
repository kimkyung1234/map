import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/key.dart';
import 'package:map/services/api.dart';
import 'package:map/widgets/bottom_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tuple/tuple.dart';

class MapPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: SlidingUpPanel(
        renderPanelSheet: false,
        panel: BottomWidget(),
        collapsed: _floatingCollapsed(),
        body: FutureBuilder<Tuple2<double, double>>(
          future: getLocation(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    onTap: (tapPosition, point) => {
                      print(point.toString()),
                    },
                    center: LatLng(snapshot.data!.item1, snapshot.data!.item2),
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
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _floatingCollapsed() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: const Center(child: Icon(Icons.keyboard_arrow_up_outlined)),
    );
  }
}
