import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'rocket_api.g.dart';

@RestApi(baseUrl: 'https://api.spacexdata.com/v4/rockets')
abstract class RocketApi {
  factory RocketApi(Dio dio, {String baseUrl}) = _RocketApi;

  @GET('/rockets')
  Future<List<Rocket>> getRockets();

  @GET('/rockets/{rocketId}')
  Future<Rocket> getRocket(@Path('rocketId') String rocketId);
}

class Rocket {
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
      height:
          '${json['height']['feet']}' ' ft' ' ${json['height']['meters']}' ' m',
      diameter: '${json['diameter']['feet']}'
          ' ft'
          ' ${json['diameter']['meters']}'
          ' m',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'engines': {
        'number': enginesCount,
      },
      'flickr_images': flickerImages,
      'active': active,
      'cost_per_launch': costPerLaunch,
      'success_rate_percent': successRatePercent,
      'description': description,
      'wikipedia': wikipedia,
      'height': {
        'feet': double.parse(height.split(' ')[0]),
        'meters': double.parse(height.split(' ')[2]),
      },
      'diameter': {
        'feet': double.parse(diameter.split(' ')[0]),
        'meters': double.parse(diameter.split(' ')[2]),
      },
    };
  }
}

class RocketApiException implements Exception {
  final String message;

  RocketApiException(this.message);
}
