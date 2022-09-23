part of 'locations_bloc.dart';

@immutable
abstract class LocationsEvent {}

class LoadLocationsEvent extends LocationsEvent {
  int? page;
  int? size;
  LoadLocationsEvent({this.page, this.size});
}
