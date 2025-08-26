import 'dart:async';
import 'dart:convert';
import 'package:bitebuddie_new_version/core/config/constants/url.dart';
import 'package:bitebuddie_new_version/features/home/presentation/data/models/toggle_onoff.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Location location = Location();
  Timer? _locationTimer;
  double? _previousLat;
  double? _previousLng;

  HomeBloc() : super(HomeInitial()) {
    on<ToggleAvailability>(toggleAvailability);
  }

  FutureOr<void> toggleAvailability(
    ToggleAvailability event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await http.patch(
        Uri.parse(Url.toggleAvailability),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final availability = AvailabilityResponse.fromJson(
          jsonDecode(response.body),
        );
        emit(ToggleOnShowOrderPopUpState(availabilityResponse: availability));

        // ✅ If available, start tracking
        if (availability.isAvailable == true) {
          await _startTracking(token!, emit);
        } else {
          _stopTracking();
        }
      } else {
        emit(ToggleError());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _startTracking(String token, Emitter<HomeState> emit) async {
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        emit(MapErrorState('Location permission denied'));
        return;
      }
    } else if (permission == PermissionStatus.deniedForever) {
      emit(MapErrorState('Location permission denied permanently'));
      return;
    }
    // 1. Request permission
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        emit(MapErrorState('Location services are disabled'));
        return;
      }
    }
    // 2. Get initial location and send it
    final current = await location.getLocation();
    final lat = current.latitude;
    final lng = current.longitude;

    if (lat == null || lng == null) {
      emit(MapErrorState('Failed to get location'));
      return;
    }

    _previousLat = lat;
    _previousLng = lng;
    await _sendLocation(lat, lng, token, emit);
    emit(LiveLocationUpdated(lat: lat, lng: lng, isAvailable: true));

    // 3. Start periodic location tracking
    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(Duration(seconds: 20), (_) async {
      final newLoc = await location.getLocation();
      final newLat = newLoc.latitude;
      final newLng = newLoc.longitude;

      if (newLat != _previousLat || newLng != _previousLng) {
        _previousLat = newLat;
        _previousLng = newLng;

        if (!emit.isDone) {
          emit(
            LiveLocationUpdated(lat: newLat!, lng: newLng!, isAvailable: true),
          );
        }

        await _sendLocation(newLat!, newLng!, token, emit);
      } else {
        print('Location unchanged. Skipping API call.');
      }
    });
  }

  void _stopTracking() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  Future<void> _sendLocation(
    double lat,
    double lng,
    String token,
    Emitter<HomeState> emit,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(Url.updateDriverLocation),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'lat': lat, 'lng': lng}),
      );

      if (response.statusCode == 200) {
        print('Location sent: $lat, $lng');
        // }
      } else {
        print('Failed to update location');
        print('Status: ${response.statusCode}');
        print('Response: ${response.body}');

        if (!emit.isDone) {
          emit(MapErrorState('Failed to update location'));
        }
      }
    } catch (e) {
      print('Exception: $e');

      if (!emit.isDone) {
        emit(MapErrorState('Error: $e'));
      }
    }
  }

  @override
  Future<void> close() {
    _stopTracking();
    return super.close();
  }
}
