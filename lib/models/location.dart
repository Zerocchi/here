import 'package:geolocator/geolocator.dart';

class Location {
  final Position position;
  final Placemark placemark;

  const Location({this.position, this.placemark});
}