import 'package:geolocator/geolocator.dart';

import 'package:here/models/location.dart';

abstract class LocationService {
  
  Stream<Position> getPosition();
  Future<Position> getLastPosition();
  Future<List<Placemark>> getPlacemarks(Position position);
  Location getLocation(Position position, Placemark placemark);

}

class LocationServiceImpl implements LocationService {
  Geolocator geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

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

  Future<bool> lesserthanMeters(double meters, Position currentPos, Position lastPos) async {
    double distance = await getDistance(currentPos, lastPos);
    return distance <= meters ? true : false;
  }
}