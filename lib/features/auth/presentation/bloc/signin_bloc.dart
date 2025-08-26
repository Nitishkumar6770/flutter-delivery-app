import 'dart:convert';
import 'package:bitebuddie_new_version/core/config/constants/url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'signIn_event.dart';
import 'signIn_state.dart';
import 'package:bloc/bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SendOtpRequested>(_onSendOtp);
    on<VerifyOtpRequested>(_onVerifyOtp);
  }

  Future<void> _onSendOtp(
    SendOtpRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    print('object');
    try {
      print('1');
      final response = await http.post(
        Uri.parse(Url.sendOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': event.phone}),
      );
      print('after try');
      if (response.statusCode == 200) {
        print(response.body);
        emit(OtpSentState(event.phone, event.isLogin));
      } else {
        print(response.statusCode);
        final message =
            jsonDecode(response.body)['message'] ?? 'Failed to send OTP';
        emit(SignInFailure(message));
      }
    } catch (e) {
      emit(SignInFailure('Error: $e'));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    try {
      final response = await http.post(
        Uri.parse(Url.verifyOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': event.phone,
          'otp': event.otp,
          'fcmToken': event.fcmToken,
        }),
      );
      print(event.fcmToken + ' fcm');
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['token'];
        // print('phone token: $token');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        print('object');
        emit(SignInSuccess(event.isLogin));
      } else {
        final message =
            jsonDecode(response.body)['message'] ?? 'OTP verification failed';
        emit(SignInFailure(message));
      }
    } catch (e) {
      emit(SignInFailure('Error: $e'));
    }
  }
}
