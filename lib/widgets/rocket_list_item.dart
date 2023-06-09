import 'package:flutter/material.dart';

import 'package:spacex/services/rocket_api.dart';

import '../screens/rocket_detail_screen.dart';

class RocketListItem extends StatelessWidget {
  final Rocket rocket;

  // ignore: use_key_in_widget_constructors
  const RocketListItem({required this.rocket});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RocketDetailScreen(rocketId: rocket.id),
            ),
          );
        },
        child: Image.network(
            rocket.flickerImages[0]), // Display the first image URL
      ),
      title: Text(rocket.name),
      subtitle: Text(rocket.country),
    );
  }
}
