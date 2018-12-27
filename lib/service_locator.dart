import 'package:get_it/get_it.dart';

import 'package:here/services/location_fetcher.dart';
import 'package:here/services/venue_fetcher.dart';

import 'package:here/blocs/location_bloc.dart';
import 'package:here/blocs/venue_bloc.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerLazySingleton<LocationFetcher>(() => LocationFetcher());
  sl.registerLazySingleton<VenueFetcher>(() => VenueFetcher());
  sl.registerSingleton<LocationBloc>(LocationBloc());
  sl.registerSingleton<VenueBloc>(VenueBloc());

  // initializing stuff before anything
  sl.get<LocationBloc>().getCurrentLocation();
}