class SigninDataResponseModels {
  final String message;
  final String token;

  SigninDataResponseModels({
    required this.message,
    required this.token,
  });

  factory SigninDataResponseModels.fromJson(Map<String, dynamic> json) {
    return SigninDataResponseModels(
      message: json['message'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
    };
  }
}