import 'package:flutter/material.dart';
import 'screens/rocket_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpaceX Rockets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RocketListScreen(),
    );
  }
}
