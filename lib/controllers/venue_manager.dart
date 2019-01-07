import 'package:rxdart/rxdart.dart';

import 'package:geolocator/geolocator.dart';
import 'package:here/service_locator.dart';

import 'package:here/models/venue.dart';
import 'package:here/services/venue_service.dart';

abstract class VenueManager {
  Observable<List<Venue>> get venues;

  void getVenues(Position position);
}

class VenueManagerImpl implements VenueManager {
  final _venueController = ReplaySubject<List<Venue>>();

  Observable<List<Venue>> get venues => _venueController.stream;

  void getVenues(Position position) async {
    List<Venue> venues = await sl.get<VenueService>().getVenues(position);
    _venueController.sink.add(venues);
  }

  void dispose() {
    _venueController.close();
  }
}