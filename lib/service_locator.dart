import 'package:get_it/get_it.dart';

import 'package:here/services/location_service.dart';
import 'package:here/services/venue_service.dart';
import 'package:here/services/map_service.dart';

import 'package:here/controllers/location_manager.dart';
import 'package:here/controllers/venue_manager.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerLazySingleton<LocationService>(() => LocationServiceImpl());
  sl.registerLazySingleton<VenueService>(() => VenueServiceImpl());
  sl.registerLazySingleton<MapService>(() => MapServiceImpl());
  sl.registerSingleton<LocationManager>(LocationManagerImpl());
  sl.registerSingleton<VenueManager>(VenueManagerImpl());

  // initializing stuff before anything
  sl.get<LocationManager>().getCurrentLocation();
  sl.get<VenueService>().loadKeys();
}