import 'package:async/async.dart';
import 'package:geolocator/geolocator.dart';

import 'package:here/models/location.dart';

class LocationFetcher {
  static LocationFetcher _fetcher = LocationFetcher._internal();
  Geolocator geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high);

  LocationFetcher._internal();

  factory LocationFetcher() {
    if(_fetcher == null) return LocationFetcher();
    else return _fetcher;
  }

  Stream<Position> getPosition() {
    return geolocator.getPositionStream(locationOptions);
  }

  Future<Position> getLastPosition() {
    // only run once to get the result
    return Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Placemark>> getPlacemarks(Position position) {
    Future<List<Placemark>> placemarks = geolocator.placemarkFromCoordinates(
      position.latitude, position.longitude);
    return placemarks;
  }

  Location getLocation(Position position, Placemark placemark) {
    return Location(position: position, placemark: placemark);
  }

  Future<double> getDistance(Position currentPos, Position lastPos) async {
    return await geolocator.distanceBetween(
      currentPos.latitude, currentPos.longitude, lastPos.latitude, lastPos.longitude
    );
  }
}