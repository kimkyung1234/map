import 'package:flutter/material.dart';
import 'package:map/services/api.dart';
import 'package:mapbox_search/mapbox_search.dart';

class RecommendWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MapBoxPlace>?>(
      future: recommendPlace(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data?.length == 0) {
          return const SizedBox();
        }

        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final data = snapshot.data?[index];
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                width: MediaQuery.of(context).size.width * 0.6,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffFE914A),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        data?.text ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
