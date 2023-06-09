import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex/services/rocket_api.dart';
import 'package:spacex/widgets/rocket_detail_item.dart';

import '../services/rocket_service.dart';

final rocketFutureProvider =
    FutureProvider.family<Rocket, String>((ref, rocketId) async {
  final rocketService = ref.read(rocketServiceProvider);
  return rocketService.getRocket(rocketId);
});

class RocketDetailScreen extends ConsumerWidget {
  final String rocketId;

  // ignore: use_key_in_widget_constructors
  const RocketDetailScreen({required this.rocketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rocketFuture = ref.watch(rocketFutureProvider(rocketId));

    return Scaffold(
      appBar: AppBar(),
      body: rocketFuture.when(
        data: (rocket) => ListView(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rocket.flickerImages.length,
                itemBuilder: (context, index) {
                  final imageUrl = rocket.flickerImages[index];
                  return Image.network(imageUrl);
                },
              ),
            ),
            RocketDetailItem(label: 'Name', value: rocket.name),
            RocketDetailItem(
                label: 'Active Status', value: rocket.active.toString()),
            RocketDetailItem(
                label: 'Cost per Launch', value: '\$${rocket.costPerLaunch}'),
            RocketDetailItem(
                label: 'Success Rate', value: '${rocket.successRatePercent}%'),
            RocketDetailItem(label: 'Description', value: rocket.description),
            RocketDetailItem(label: 'Wikipedia', value: rocket.wikipedia),
            RocketDetailItem(label: 'Height', value: rocket.height),
            RocketDetailItem(label: 'Diameter', value: rocket.diameter),
          ],
        ),
        error: (error, stackTrace) => const Center(
            child: Text('An error occurred while fetching rocket details')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
