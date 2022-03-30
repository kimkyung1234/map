class Weather {
  late final String temp;
  late final String city;
  late final String description;
  late final String country;
  late final String icon;
  late final double lon;
  late final double lat;

  Weather({
    required this.temp,
    required this.city,
    required this.description,
    required this.country,
    required this.icon,
    required this.lon,
    required this.lat,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toString() + '°C',
      city: json['name'],
      description: json['weather'][0]['description'],
      country: json['sys']['country'],
      icon: json['weather'][0]['icon'],
      lon: json['coord']['lon'],
      lat: json['coord']['lat'],
    );
  }
}
