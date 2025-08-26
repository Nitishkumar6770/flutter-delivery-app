abstract class SignInEvent {}

class SendOtpRequested extends SignInEvent {
  final String phone;
  final bool isLogin;

  SendOtpRequested({required this.phone, required this.isLogin});
}

class VerifyOtpRequested extends SignInEvent {
  final String phone;
  final String otp;
  final bool isLogin;
  final String fcmToken;

  VerifyOtpRequested({
    required this.fcmToken,
    required this.phone,
    required this.otp,
    required this.isLogin,
  });
}
