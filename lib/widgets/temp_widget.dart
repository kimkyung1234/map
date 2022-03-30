import 'package:flutter/material.dart';
import 'package:map/models/weather_model.dart';
import 'package:map/services/weather_api.dart';
import 'package:map/widgets/common.dart';

class WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: FutureBuilder<Weather>(
          future: getCurrentWeatherData(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('..'));
            }
            return flexibleText(
                text: snapshot.data!.temp, alignment: Alignment.center);
          },
        ),
      ),
    );
  }
}
