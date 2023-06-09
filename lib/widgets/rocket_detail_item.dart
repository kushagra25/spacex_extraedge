import 'package:flutter/material.dart';

class RocketDetailItem extends StatelessWidget {
  final String label;
  final String value;

  // ignore: use_key_in_widget_constructors
  const RocketDetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
