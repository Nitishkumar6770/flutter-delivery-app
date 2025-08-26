class Url {
  static const String baseUrl = 'http://$localHost';
  static const String localHost = '172.31.16.1';
  static const String port3000 = ':3000';
  static const String port3012 = ':3012';
  static const String sendOtp = '$baseUrl$port3000/api/auth/driver/loginOtp';
  static const String verifyOtp =
      '$baseUrl$port3000/api/auth/driver/verify-otp';
  static const String personalInfo =
      '$baseUrl$port3012/api/driver/personal-info';
  static const String profile = '$baseUrl$port3012/api/driver/profile';
  static const String vehicleInfo = '$baseUrl$port3012/api/driver/vehicle-info';
  static const String updateDriverLocation =
      '$baseUrl$port3012/api/driver/update-driver-location';
  static const String toggleAvailability =
      '$baseUrl$port3012/api/driver/toggle-availability';
}
