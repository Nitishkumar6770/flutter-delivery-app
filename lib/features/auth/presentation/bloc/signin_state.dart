abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class OtpSentState extends SignInState {
  final String phone;
  final bool isLogin;

  OtpSentState(this.phone, this.isLogin);
}

class SignInSuccess extends SignInState {
  final bool isLogin;

  SignInSuccess(this.isLogin);
}

class SignInFailure extends SignInState {
  final String message;

  SignInFailure(this.message);
}
