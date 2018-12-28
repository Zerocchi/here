import 'package:flutter/material.dart';

import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:geolocator/geolocator.dart';

class PositionCard extends StatelessWidget {

  final Position position;

  PositionCard({@required this.position});

  @override
  Widget build(BuildContext context) {

    TextStyle headerStyle = TextStyle(fontSize: 32, color: Colors.white70);
    TextStyle contentStyle = TextStyle(fontSize: 16, color: Colors.white);

    return GradientCard(
      gradient: Gradients.cosmicFusion,
      child: Column(
        children: [
          Text("Position", style: headerStyle),
          Text("Latitude: ${position.latitude.toStringAsFixed(5)}", style: contentStyle),
          Text("Longitude: ${position.longitude.toStringAsFixed(5)}", style: contentStyle),
          Text("Altitude: ${position.altitude}", style: contentStyle),
          Text("Speed: ${position.speed.toStringAsFixed(2)}", style: contentStyle),
        ],
      ),
    );
  }
}