import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/key.dart';
import 'package:map/providers/map_provider.dart';
import 'package:map/providers/theme_changer.dart';
import 'package:map/services/api.dart';
import 'package:map/widgets/bottom_widget.dart';
import 'package:map/widgets/popup_menu.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tuple/tuple.dart';

class MapPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapProvider>(context);
    var theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: null,
        child: PopupMenu(),
      ),
      body: SlidingUpPanel(
        renderPanelSheet: false,
        panel: BottomWidget(mapController: mapController),
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
                          'https://api.mapbox.com/styles/v1/mapbox/${theme.getTheme}/tiles/{z}/{x}/{y}?access_token=${Keys.mapbox2}',
                      additionalOptions: {
                        'accessToken': Keys.mapbox2,
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        if (provider.getHome != null)
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(provider.getHome?.item1,
                                provider.getHome?.item2),
                            builder: (ctx) => const Icon(
                              Icons.home,
                              color: Colors.orange,
                              size: 40,
                            ),
                          ),
                      ],
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
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: const Center(child: Icon(Icons.keyboard_arrow_up_outlined)),
    );
  }
}
