import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:geolocator/geolocator.dart';
import 'package:here/service_locator.dart';

import 'package:here/services/location_service.dart';
import 'package:here/models/location.dart';

abstract class LocationManager {
  Observable<Location> get location;

  void getCurrentLocation();
  void getLastPosition();
}

class LocationManagerImpl implements LocationManager {
  final _positionController = ReplaySubject<Position>();
  final _lastPositionController = BehaviorSubject<Position>();
  final _placemarksController = ReplaySubject<List<Placemark>>();
  final _locationController = ReplaySubject<Location>();
  final _positionDiffController = ReplaySubject<bool>();

  StreamSubscription<Position> _positionListener; 

  Observable<Location> get location => _locationController.stream;
  Observable<Position> get lastPosition => _lastPositionController.stream;
  Observable<bool> get positionDifference => _positionDiffController.stream;

  void getCurrentLocation() {
    _positionListener = sl.get<LocationService>().getPosition().listen(
      (Position currentPos) async {
        var _placemarks = await sl.get<LocationService>().getPlacemarks(currentPos);
        Location location = sl.get<LocationService>().getLocation(currentPos, _placemarks[0]);
        _locationController.sink.add(location);
      }
    );
  }

  void getLastPosition() async {
    Position position = await sl.get<LocationService>().getLastPosition();
    _lastPositionController.sink.add(position);
  }


  void dispose() {
    _positionController.close();
    _placemarksController.close();
    _locationController.close();
    _lastPositionController.close();
    _positionDiffController.close();
    _positionListener.cancel();
  }
}