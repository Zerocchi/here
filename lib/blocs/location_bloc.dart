import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:geolocator/geolocator.dart';
import 'package:here/service_locator.dart';

import 'package:here/services/location_fetcher.dart';
import 'package:here/models/location.dart';

class LocationBloc {
  final _positionController = ReplaySubject<Position>();
  final _lastPositionController = BehaviorSubject<Position>();
  final _placemarksController = ReplaySubject<List<Placemark>>();
  final _locationController = ReplaySubject<Location>();

  StreamSubscription<Position> _positionListener; 

  Observable<Location> get location => _locationController.stream;
  Observable<Position> get lastPosition => _lastPositionController.stream;

  void getCurrentLocation() {
    _positionListener = sl.get<LocationFetcher>().getPosition().listen(
      (Position currentPos) async {
        var _placemarks = await sl.get<LocationFetcher>().getPlacemarks(currentPos);
        Location location = sl.get<LocationFetcher>().getLocation(currentPos, _placemarks[0]);
        _locationController.sink.add(location);
      }
    );
  }

  void getLastPosition() async {
    Position position = await sl.get<LocationFetcher>().getLastPosition();
    _lastPositionController.sink.add(position);
  }

  void dispose() {
    _positionController.close();
    _placemarksController.close();
    _locationController.close();
    _lastPositionController.close();
    _positionListener.cancel();
  }
}