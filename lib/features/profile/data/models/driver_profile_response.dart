class DriverProfileResponse {
  final String message;
  final Driver driver;

  DriverProfileResponse({
    required this.message,
    required this.driver,
  });

  factory DriverProfileResponse.fromJson(Map<String, dynamic> json) {
    return DriverProfileResponse(
      message: json['message'],
      driver: Driver.fromJson(json['driver']),
    );
  }
}

class Driver {
  final String id;
  final String phone;
  final String email;
  final String name;
  final String imageUrl;

  Driver({
    required this.id,
    required this.phone,
    required this.email,
    required this.name,
    required this.imageUrl
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'],
      phone: json['phone'],
      email: json['email'],
      name: json['name'],
      imageUrl: json['profilePhoto'],
    );
  }
}
