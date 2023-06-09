import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:spacex/services/rocket_api.dart';
import '../services/rocket_service.dart';
import '../widgets/rocket_list_item.dart';

final rocketsFutureProvider = FutureProvider<List<Rocket>>((ref) async {
  final rocketService = ref.read(rocketServiceProvider);
  return rocketService.getRockets();
});

class RocketListScreen extends ConsumerWidget {
  // ignore: use_key_in_widget_constructors
  const RocketListScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rocketsFuture = ref.watch(rocketsFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('SpaceX Rockets')),
      body: rocketsFuture.when(
        data: (rockets) {
          return ListView.builder(
            itemCount: rockets.length,
            itemBuilder: (context, index) {
              final rocket = rockets[index];
              return RocketListItem(rocket: rocket);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
