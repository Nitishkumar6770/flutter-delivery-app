import 'dart:async';
import 'dart:convert';
import 'package:bitebuddie_new_version/core/config/constants/url.dart';
import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/data/models/personal_info_response.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'personalinfo_event.dart';
part 'personalinfo_state.dart';

class PersonalinfoBloc extends Bloc<PersonalinfoEvent, PersonalinfoState> {
  PersonalinfoBloc() : super(PersonalinfoInitial()) {
    on<PersonalInfoFetchEvent>(_personalInfoFetchEvent);
  }

  FutureOr<void> _personalInfoFetchEvent(
    PersonalInfoFetchEvent event,
    Emitter<PersonalinfoState> emit,
  ) async {
    emit(PersonalinfoLoading(
    ));
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        emit(PersonalinfoError(errormessage: 'Token not found'));
      }
      final response = await http.get(
        Uri.parse(Url.personalInfo),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final personalInfoResponse = PersonalInfoResponse.fromJson(
          jsonDecode(response.body),
        );
        // print(response.body);
        emit(PersonalinfoLoaded(personalInfoResponse: personalInfoResponse));
      } else {
        emit(PersonalinfoError(errormessage: 'Failed to Load PersonalInfo'));
      }
    } catch (e) {
      emit(PersonalinfoError(errormessage: 'Error ${e.toString()}'));
    }
  }
}
