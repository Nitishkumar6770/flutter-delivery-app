class PersonalInfoResponse {
  final String message;
  final Driver driver;

  PersonalInfoResponse({required this.message, required this.driver});

  factory PersonalInfoResponse.fromJson(Map<String, dynamic> json) {
    return PersonalInfoResponse(
      message: json['message'],
      driver: Driver.fromJson(json['driver']),
    );
  }
}

class Driver {
  final String id;
  final String adharCard;
  final String drivingLicense;
  final String email;
  final String name;
  final String phone;

  Driver({
    required this.id,
    required this.adharCard,
    required this.drivingLicense,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'] ?? '',
      adharCard: json['adharCard'] ?? '',
      drivingLicense: json['drivingLicense'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
