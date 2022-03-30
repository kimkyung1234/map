class Location {
  final int id;
  final double lat;
  final double lon;

  Location({
    required this.id,
    required this.lat,
    required this.lon,
  });

  Location.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        lat = res['lat'],
        lon = res['lon'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'lat': lat,
      'lon': lon,
    };
  }
}
