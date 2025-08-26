import 'dart:async';
import 'dart:convert';
import 'package:bitebuddie_new_version/core/config/constants/url.dart';
import 'package:bitebuddie_new_version/features/profile/pages/vehicle_information/data/models/vehicle_info_response.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'vehicle_info_event.dart';
part 'vehicle_info_state.dart';

class VehicleInfoBloc extends Bloc<VehicleInfoEvent, VehicleInfoState> {
  VehicleInfoBloc() : super(VehicleInfoInitial()) {
    on<VehicleInfoFetchEvent>(vehicleInfoFetchEvent);
  }

  FutureOr<void> vehicleInfoFetchEvent(
    VehicleInfoFetchEvent event,
    Emitter<VehicleInfoState> emit,
  ) async {
    emit(VehicleInfoLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final response = await http.get(
        Uri.parse(Url.vehicleInfo),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final vehicleInfoResponse = VehicleInfoResponse.fromJson(
          jsonDecode(response.body),
        );
        emit(VehicleInfoLoaded(vehicleInfoResponse: vehicleInfoResponse));
      } else {
        emit(VehicleInfoError(errorMessage: 'failed to load vehicle info'));
      }
    } catch (e) {
      emit(VehicleInfoError(errorMessage: 'Error ${e.toString()}'));
    }
  }
}
