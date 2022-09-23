import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_course_autumn_2021/model/locations_model.dart';
import 'package:flutter_course_autumn_2021/service/location_service.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc() : super(LocationsInitial()) {
    on<LoadLocationsEvent>((event, emit) async {
      emit(LoadingLocationsState());
      try {
        // SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // Map<String, dynamic> userDetails =
        //     jsonDecode(sharedPreferences.getString('backend_user') ?? '{}');
        List<LocationsModel> locations = await locationsService.getAllLocations(
            (await SharedPreferences.getInstance()).getString('backed_token') ??
                'EMPTY_TOKEN',
            page: event.page,
            size: event.size);
        emit(LocationsDataState(locations));
      } catch (e) {
        emit(LocationsErrorState());
      }
    });
  }
  LocationsService locationsService = LocationsService();
}
