import 'package:map/key.dart';
import 'package:mapbox_search/mapbox_search.dart';

void main() async {
  var a = await geoCoding(Keys.mapbox2);
  print(a);
}

Future geoCoding(String apiKey) async {
  var geoCodingService = ReverseGeoCoding(
    apiKey: apiKey,
    limit: 10,
  );

  var addresses = await geoCodingService.getAddress(Location(
    lat: 37.517436,
    lng: 127.037209,
  ));

  return addresses;
}
