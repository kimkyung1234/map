import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/pages/search.dart';
import 'package:map/pages/setting.dart';
import 'package:map/providers/map_provider.dart';
import 'package:map/widgets/common.dart';
import 'package:map/widgets/recommend_widget.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapProvider>(context);
    MapController? mapController = provider.getMapController;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Icon(Icons.keyboard_arrow_down_outlined),
          Container(
            height: 170,
            margin: const EdgeInsets.all(20),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 140,
                  decoration: const BoxDecoration(
                    color: Color(0xff5AB27D),
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        flexibleText(
                          text: 'Search',
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Container(
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xffF8B8BC),
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (provider.getHome != null) {
                        Tuple2? data = provider.getHome;
                        mapController!.move(
                          LatLng(data?.item1, data?.item2),
                          18,
                        );
                      } else {
                        customDialog(
                          context: context,
                          text: 'You have to set your home location',
                        );
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        flexibleText(
                          text: 'Home',
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    Container(
                      width: 75,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(24.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 0.2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingPage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 75,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFF2D0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.0),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SettingPage(),
                          //   ),
                          // );
                        },
                        child: const Icon(
                          Icons.star,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          RecommendWidget(mapController: mapController!),
        ],
      ),
    );
  }
}
