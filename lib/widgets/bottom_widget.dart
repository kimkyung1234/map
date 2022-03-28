import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/pages/setting.dart';
import 'package:map/providers/map_provider.dart';
import 'package:map/widgets/common.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class BottomWidget extends StatelessWidget {
  final MapController mapController;

  const BottomWidget({
    Key? key,
    required this.mapController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapProvider>(context);

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
                    onTap: () {},
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
                const SizedBox(width: 15),
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
                      Tuple2 a = provider.getHome;
                      mapController.move(
                        LatLng(a.item1, a.item2),
                        18,
                      );
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
                Container(
                  width: 75,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
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
              ],
            ),
          ),
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
            ),
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          ),
        ],
      ),
    );
  }
}
