import 'dart:async';
import 'dart:convert';
import 'package:bitebuddie_new_version/core/config/constants/url.dart';
import 'package:bitebuddie_new_version/features/profile/data/models/driver_profile_response.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(_profileInitialEvent);
  }

  FutureOr<void> _profileInitialEvent(
    ProfileInitialEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      // final token =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6ODk4NjgzOTczNSwiZHJpdmVySWQiOiI2ODVkMjBiYTEyMmFlNDJjOTFmNWZjNGMiLCJpYXQiOjE3NTIwNDkwNjcsImV4cCI6MTc1MjMwODI2N30.ZCOn7qmXNkDqKWhM4YdF3F0qDf2HnsLLUwHz2dxxaHQ";

      // ignore: unnecessary_null_comparison
      if (token == null) {
        emit(ProfileError('Auth token not found.'));
        return;
      }
      final response = await http.get(
        Uri.parse(Url.profile),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final driver = DriverProfileResponse.fromJson(
          jsonDecode(response.body),
        );

        emit(ProfileLoaded(driver: driver));
      } else {
        print(response.statusCode);
        emit(ProfileError('Failed to load profile'));
        // print(response.statusCode);
        // print(response.body);
      }
    } catch (e) {
      emit(ProfileError('Error: $e'));
    }
  }
}
