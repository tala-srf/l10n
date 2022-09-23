part of 'locations_bloc.dart';

@immutable
abstract class LocationsState {}

class LocationsInitial extends LocationsState {}

class LoadingLocationsState extends LocationsState {}

class LocationsDataState extends LocationsState {
  List<LocationsModel> locations;
  LocationsDataState(this.locations);
}

class LocationsErrorState extends LocationsState {}
