import 'package:map/key.dart';
import 'package:mapbox_search/mapbox_search.dart';

void main() async {
  List<MapBoxPlace>? a = await placesSearch(Keys.mapbox2);
  print(a?[1].context);
}

Future<List<MapBoxPlace>?> placesSearch(String apiKey) async {
  var placesService = PlacesSearch(
    apiKey: apiKey,
    limit: 5,
  );

  var places = await placesService.getPlaces('a');

  print(places);
  return places;
}
