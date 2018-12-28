import 'package:flutter/material.dart';

import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:geolocator/geolocator.dart';

class PlacemarkCard extends StatelessWidget {

  final Placemark placemark;

  PlacemarkCard({@required this.placemark});

  @override
  Widget build(BuildContext context) {

    TextStyle headerStyle = TextStyle(fontSize: 32, color: Colors.white70);
    TextStyle contentStyle = TextStyle(fontSize: 16, color: Colors.white);

    return GradientCard(
      gradient: Gradients.hotLinear,
      child: Column(
        children: [
          Text("Placemark", style: headerStyle),
          Text("Name: ${placemark.name}", style: contentStyle),
          Text("SubThoroughfare: ${placemark.subThoroughfare}", style: contentStyle),
          Text("Thoroughfare: ${placemark.thoroughfare}", style: contentStyle),
          Text("SubLocality: ${placemark.subLocality}", style: contentStyle),
          Text("Locality: ${placemark.locality}", style: contentStyle),
          Text("Postal Code: ${placemark.postalCode}", style: contentStyle),
          Text("SubAdmin: ${placemark.subAdministratieArea}", style: contentStyle),
          Text("State/Admin: ${placemark.administrativeArea}", style: contentStyle),
          Text("Country: ${placemark.country}", style: contentStyle),
        ],
      ),
    );
  }
}