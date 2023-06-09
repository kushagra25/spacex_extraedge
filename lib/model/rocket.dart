/*class Rocket {
  final String id;
  final String name;
  final String country;
  final int enginesCount;
  final List<String> flickerImages;
  final bool active;
  final int costPerLaunch;
  final int successRatePercent;
  final String description;
  final String wikipedia;
  final String height;
  final String diameter;

  Rocket({
    required this.id,
    required this.name,
    required this.country,
    required this.enginesCount,
    required this.flickerImages,
    required this.active,
    required this.costPerLaunch,
    required this.successRatePercent,
    required this.description,
    required this.wikipedia,
    required this.height,
    required this.diameter,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      enginesCount: json['engines']['number'],
      flickerImages: json['flickr_images'] != null
          ? List<String>.from(json['flickr_images'])
          : [],
      active: json['active'],
      costPerLaunch: json['cost_per_launch'],
      successRatePercent: json['success_rate_percent'],
      description: json['description'],
      wikipedia: json['wikipedia'],
      // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
      height: '${json['height']['feet']}' +
          ' ft' +
          ' ${json['height']['meters']}' +
          ' m',
      // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
      diameter: '${json['diameter']['feet']}' +
          ' ft' +
          ' ${json['diameter']['meters']}' +
          ' m',
    );
  }
}*/
